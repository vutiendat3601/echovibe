import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { CheckboxModule } from 'primeng/checkbox';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ConfirmPopupModule } from 'primeng/confirmpopup';
import { DialogModule } from 'primeng/dialog';
import { EditorModule } from 'primeng/editor';
import { FloatLabelModule } from 'primeng/floatlabel';
import { IconFieldModule } from 'primeng/iconfield';
import { ImageModule } from 'primeng/image';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputIconModule } from 'primeng/inputicon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { MultiSelectFilterEvent, MultiSelectModule } from 'primeng/multiselect';
import { PanelModule } from 'primeng/panel';
import { PopoverModule } from 'primeng/popover';
import { RadioButtonModule } from 'primeng/radiobutton';
import { RatingModule } from 'primeng/rating';
import { RippleModule } from 'primeng/ripple';
import { SelectModule } from 'primeng/select';
import { Table, TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { ToastModule } from 'primeng/toast';
import { ToolbarModule } from 'primeng/toolbar';
import { map } from 'rxjs';
import { ARTIST_NATIONALITIES, UNDEFINED, URL_REGEX } from '../../../constant/constant';
import { ResponseDto } from '../../../dto/response-dto';
import { CommandResult } from '../../../model/command-result';
import { Tag } from '../../../model/tag';
import { ArtistNationalityNamePipe } from '../../../pipe/artist-nationality.pipe';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ArtistService } from '../../../service/artist.service';
import { UrlValidator } from '../../../validator/url.validator';
import {
  ArtistDto,
  CreateArtistDto,
  DeleteArtistDto,
  ReleaseArtistDto,
  UpdateArtistDto
} from './../../../dto/artist-dto';
import { ExceptionHandler, Message } from './../../../exception/exception-handler';
import { Nationality } from './../../../model/nationality';

type ActionType = 'new' | 'edit';

interface Column {
  field: string;
  header: string;
  exportHeader: string | null;
}

interface Artist {
  id: string | null;
  urn: string | null;
  name: string | null;
  isPublic: boolean;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  revisionNumber: number;
  isReleased: boolean;
  isVerified: boolean;
  refCode: string | null;
  tags: Tag[];
  tagsString?: string;
  createdAt: string | null;
  updatedAt: string | null;
  createdBy: string | null;
  updatedBy: string | null;
  tagFilterKeyword: string;
  tagFilterFoundExactMatch: boolean;
}

@Component({
  selector: 'app-artist-management',
  imports: [
    ArtistNationalityNamePipe,
    CommonModule,
    TableModule,
    FormsModule,
    ButtonModule,
    RippleModule,
    ToastModule,
    ToolbarModule,
    RatingModule,
    InputTextModule,
    TextareaModule,
    SelectModule,
    RadioButtonModule,
    InputNumberModule,
    DialogModule,
    TagModule,
    InputIconModule,
    IconFieldModule,
    ConfirmDialogModule,
    EditorModule,
    ImageModule,
    ReactiveFormsModule,
    CardModule,
    FloatLabelModule,
    PanelModule,
    ToastModule,
    ConfirmPopupModule,
    SafeHtmlPipe,
    IconFieldModule,
    InputIconModule,
    RouterModule,
    CheckboxModule,
    PopoverModule,
    MultiSelectModule,
    InputGroupModule,
    InputGroupAddonModule
  ],
  templateUrl: './artist-management.component.html',
  styleUrl: './artist-management.component.scss',
  providers: [MessageService, ArtistService, ConfirmationService, UrlValidator]
})
export class ArtistManagementComponent implements OnInit {
  readonly I18N = {
    IS_PUBLIC_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`,
    IS_PUBLIC_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`,
    IS_VERIFIED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`,
    IS_VERIFIED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`,
    IS_RELEASED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`,
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`
  };
  readonly UNDEFINED = UNDEFINED;
  readonly columns: Column[] = [
    {
      field: 'id',
      header: 'ID',
      exportHeader: 'ID'
    },
    {
      field: 'name',
      header: $localize`:@@COLUMN_LABEL_MANAGE_ARTIST_NAME:Name`,
      exportHeader: null
    }
  ];
  private readonly changedArtistIds: Set<string> = new Set();
  currentArtist: Artist = this.emptyArtist();
  readonly artistNationalities: Nationality[] = ARTIST_NATIONALITIES;
  readonly nameFormControl: FormControl = new FormControl<string>('', [Validators.required, Validators.maxLength(250)]);
  readonly descriptionFormControl: FormControl = new FormControl<string>('');
  readonly biographyFormControl: FormControl = new FormControl<string>('');
  readonly thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly backgroundUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly nationalityIsoCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly isVerifiedFormControl: FormControl = new FormControl<boolean>(false);
  readonly isPublicFormControl: FormControl = new FormControl<boolean>(false);
  readonly tagsFormControl: FormControl = new FormControl<Tag[]>([]);
  readonly refCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly artistFormGroup: FormGroup = new FormGroup({
    nameFormControl: this.nameFormControl,
    descriptionFormControl: this.descriptionFormControl,
    biographyFormControl: this.biographyFormControl,
    thumbnailUrlFormControl: this.thumbnailUrlFormControl,
    backgroundUrlFormControl: this.backgroundUrlFormControl,
    nationalityIsoCodeFormControl: this.nationalityIsoCodeFormControl,
    isVerifiedFormControl: this.isVerifiedFormControl,
    tagsFormControl: this.tagsFormControl,
    refCodeFormControl: this.refCodeFormControl,
    isPublicFormControl: this.isPublicFormControl
  });
  readonly renderableImageUrls: string[] = [];
  readonly selectedArtists: Artist[] = [];
  readonly artists: WritableSignal<Artist[]> = signal<Artist[]>([]);
  isDialogFormSubmitted: boolean = false;
  isDialogShowed: boolean = false;
  action: ActionType = 'new';
  readonly isLoading = signal<boolean>(true);

  constructor(
    private readonly messageService: MessageService,
    private readonly confirmationService: ConfirmationService,
    private readonly artistService: ArtistService,
    private readonly http: HttpClient,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    this.listenAndProcessArtistEvents();
    this.listenAndProcessFormControlValueChange();
    this.loadData();
  }

  handleHideArtistDialog(): void {
    this.isDialogShowed = false;
    this.isDialogFormSubmitted = false;
  }

  handleDeleteSelectedArtists(): void {
    const deleteArtistDtos: DeleteArtistDto[] = this.selectedArtists.map(
      ({ id }) =>
        ({
          id
        }) as DeleteArtistDto
    );
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_BULK_REQUEST_DELETE:Are you sure you want to delete the selected Artists?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_DELETE:Confirm delete`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => this.bulkDeleteArtist(deleteArtistDtos)
    });
  }

  handleReleaseSelectedArtists(): void {
    const releaseArtistDtos: ReleaseArtistDto[] = this.selectedArtists.map(
      ({ id }) =>
        ({
          id
        }) as ReleaseArtistDto
    );
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_BULK_REQUEST_RELEASE:Are you sure you want to release the selected Artists?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_RELEASE:Confirm release`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => this.bulkReleaseArtist(releaseArtistDtos)
    });
  }

  handleEditSelectedArtists(): void {
    if (this.selectedArtists.length === 1) {
      this.handleEditArtist(this.selectedArtists[0]);
    } else if (this.selectedArtists.length > 1) {
      const ids = this.selectedArtists.map((artist) => artist.id).join(',');
      this.router.navigate(['/management/artist/bulk'], { queryParams: { ids } });
    }
  }

  handleImportCsv(): void {
    this.router.navigate(['/management/artist/bulk']);
  }

  handleExportCsv(): void {}

  handleGlobalFilter(table: Table, event: Event) {
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }

  handleNewArtist(): void {
    this.currentArtist = this.emptyArtist();
    this.refCodeFormControl.enable();
    if (this.action === 'edit' || this.isDialogFormSubmitted) {
      // These two cases: [The action is edit before, the Artist (create, edit) was saved]
      // We'll erase the data in the form.
      this.artistFormGroup.reset();
    }
    this.openArtistDialog('new');
  }

  handleEditArtist(artist: Artist): void {
    this.currentArtist = artist;
    const { name, description, biography, thumbnailUrl, backgroundUrl, nationalityIsoCode, refCode, isPublic, tags } =
      this.currentArtist;
    this.nameFormControl.setValue(name);
    this.descriptionFormControl.setValue(description);
    this.biographyFormControl.setValue(biography);
    this.backgroundUrlFormControl.setValue(backgroundUrl);
    this.nationalityIsoCodeFormControl.setValue(nationalityIsoCode);
    this.thumbnailUrlFormControl.setValue(thumbnailUrl);
    this.refCodeFormControl.setValue(refCode);
    this.isPublicFormControl.setValue(isPublic);
    this.tagsFormControl.setValue(tags.filter(({ isActive }) => isActive).map(({ name }) => name));
    artist.revisionNumber > -1 && this.refCodeFormControl.disable();
    this.openArtistDialog('edit');
  }

  handleSaveArtist(): void {
    if (this.action === 'new') {
      const createArtistDto: CreateArtistDto = {
        profile: {
          name: this.currentArtist.name,
          description: this.currentArtist.description,
          biography: this.currentArtist.biography,
          nationalityIsoCode: this.currentArtist.nationalityIsoCode,
          thumbnailUrl: this.currentArtist.thumbnailUrl,
          backgroundUrl: this.currentArtist.backgroundUrl
        },
        refCode: this.currentArtist.refCode,
        isPublic: this.currentArtist.isPublic,
        tags: this.currentArtist.tags
      };
      this.createArtist(createArtistDto);
    } else if (this.action === 'edit') {
      if (this.currentArtist.id) {
        const updateArtistDto: UpdateArtistDto = {
          id: this.currentArtist.id,
          profile: {
            name: this.currentArtist.name,
            description: this.currentArtist.description,
            biography: this.currentArtist.biography,
            nationalityIsoCode: this.currentArtist.nationalityIsoCode,
            thumbnailUrl: this.currentArtist.thumbnailUrl,
            backgroundUrl: this.currentArtist.backgroundUrl
          },
          refCode: this.currentArtist.refCode,
          isPublic: this.currentArtist.isPublic,
          tags: this.currentArtist.tags
        };
        this.updateArtist(updateArtistDto);
      }
    }
  }

  handleDeleteArtist({ id }: Artist): void {
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_DELETE:Are you sure you want to delete the selected Artist?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_DELETE:Confirm delete`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => id && this.deleteArtist({ id })
    });
  }

  handleReleaseArtist({ id }: Artist): void {
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_RELEASE:Are you sure you want to release the selected Artist?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_RELEASE:Confirm release`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => id && this.releaseArtist({ id })
    });
  }

  handleTagFilter(event: MultiSelectFilterEvent) {
    const tags = this.currentArtist.tags;
    const tagName = event.filter;
    this.currentArtist.tagFilterKeyword = tagName;
    if (tagName?.trim()) {
      this.currentArtist.tagFilterFoundExactMatch = tags.some(({ name }) => name === tagName);
    } else {
      this.currentArtist.tagFilterFoundExactMatch = true;
    }
  }

  handleCreateTag(): void {
    if (this.currentArtist.tagFilterKeyword?.trim()) {
      const tagName: string = this.currentArtist.tagFilterKeyword;
      const tags = this.currentArtist.tags;
      if (!tags.some(({ name }) => name === tagName)) {
        this.currentArtist.tags.push({ name: tagName, isActive: false });
        this.currentArtist.tagFilterKeyword = '';
        this.currentArtist.tagFilterFoundExactMatch = true;
      }
    }
  }

  private openArtistDialog(action: ActionType): void {
    if (this.action == action) {
      this.isDialogShowed = true;
    } else {
      this.action = action;
      this.isDialogFormSubmitted = false;
      this.isDialogShowed = true;
    }
  }

  private createArtist(createArtistDto: CreateArtistDto): void {
    this.artistService.bulkCreateArtist({ items: [createArtistDto] }).subscribe((respDto) => {
      const { isSuccessful, errors }: CommandResult = respDto.data.items[0];
      if (isSuccessful) {
        this.isDialogFormSubmitted = true;
        this.isDialogShowed = false;
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_ARTIST_CREATED_SUCCESSFUL:Artist was created successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private updateArtist(updateArtistDto: UpdateArtistDto): void {
    this.artistService.bulkUpdateArtist({ items: [updateArtistDto] }).subscribe((respDto) => {
      const { isSuccessful, errors }: CommandResult = respDto.data.items[0];
      if (isSuccessful) {
        this.isDialogFormSubmitted = true;
        this.isDialogShowed = false;
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_ARTIST_UPDATED_SUCCESSFUL:Artist was updated successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private deleteArtist(deleteArtistDto: DeleteArtistDto) {
    this.artistService.bulkDeleteArtist({ items: [deleteArtistDto] }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_ARTIST_DETELED_SUCCESSFUL:Artist was deleted successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private bulkDeleteArtist(deleteArtistDtos: DeleteArtistDto[]) {
    this.artistService.bulkDeleteArtist({ items: deleteArtistDtos }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        const deletedArtistIds = deleteArtistDtos.map(({ id }) => id);
        this.artists.update((artists) => artists.filter(({ id }) => id && !deletedArtistIds.includes(id)));
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_ARTIST_BULK_REQUEST_DETELE_SUCCESSFUL:Bulk delete artist was processed successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private releaseArtist(releaseArtistDto: ReleaseArtistDto) {
    this.artistService.bulkReleaseArtist({ items: [releaseArtistDto] }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_ARTIST_RELEASED_SUCCESSFUL:Bulk release Artist request was processed successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private bulkReleaseArtist(releaseArtistDtos: ReleaseArtistDto[]) {
    this.artistService.bulkReleaseArtist({ items: releaseArtistDtos }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_ARTIST_BULK_REQUEST_RELEASE_SUCCESSFUL:Bulk release Artist request was processed successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private loadData() {
    this.isLoading.set(true);
    this.artistService.getAllArtists().subscribe((respDto: ResponseDto<[ArtistDto]>) => {
      this.artists.set(respDto.data.map((artistDto) => this.mapToArtist(artistDto)));
      this.isLoading.set(false);
    });
  }

  private listenAndProcessFormControlValueChange() {
    // Name
    this.nameFormControl.valueChanges.subscribe(
      (value: string) => !this.nameFormControl.errors && (this.currentArtist.name = value)
    );

    // Description
    this.descriptionFormControl.valueChanges.subscribe(
      (value: string) => !this.descriptionFormControl.errors && (this.currentArtist.description = value)
    );

    // Biography
    this.biographyFormControl.valueChanges.subscribe(
      (value: string) => !this.biographyFormControl.errors && (this.currentArtist.biography = value)
    );

    // Nationality
    this.nationalityIsoCodeFormControl.valueChanges.subscribe(
      (value: string | null) =>
        !this.nationalityIsoCodeFormControl.errors && (this.currentArtist.nationalityIsoCode = value)
    );

    // Public
    this.isPublicFormControl.valueChanges.subscribe(
      (value: boolean) => !this.isPublicFormControl.errors && (this.currentArtist.isPublic = value)
    );

    // Verified
    this.isVerifiedFormControl.valueChanges.subscribe(
      (value: boolean) => !this.isVerifiedFormControl.errors && (this.currentArtist.isVerified = value)
    );

    // RefCode
    this.refCodeFormControl.valueChanges.subscribe(
      (value: string | null) => !this.refCodeFormControl.errors && (this.currentArtist.refCode = value)
    );

    // ThumbnailUrl
    this.thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !this.thumbnailUrlFormControl.errors &&
        ((this.currentArtist.thumbnailUrl = value), this.processImagePreview(value))
    );

    // BackgroundUrl
    this.backgroundUrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !this.backgroundUrlFormControl.errors &&
        ((this.currentArtist.backgroundUrl = value), this.processImagePreview(value))
    );

    // Tags
    this.tagsFormControl.valueChanges.subscribe(
      (values: string[]) =>
        !this.tagsFormControl.errors &&
        (this.currentArtist.tags = this.currentArtist.tags.map((tag) => ({
          ...tag,
          isActive: values.includes(tag.name)
        })))
    );
  }

  private listenAndProcessArtistEvents() {
    this.artistService.changedArtistsEvent.subscribe((artistDtos) => {
      const updatedArtistsMap: Map<string, Artist> = new Map(
        artistDtos.map((artistDto) => [artistDto.id, this.mapToArtist(artistDto)])
      );
      const renderedIds: string[] = this.artists()
        .filter((id) => id)
        .map(({ id }) => id) as string[];
      this.artists.update((artists) => {
        return [
          ...Array.from(updatedArtistsMap.values()).filter(({ id }) => id && !renderedIds.includes(id)),
          ...artists.map((artist) => (artist.id && updatedArtistsMap.get(artist.id)) || artist)
        ];
      });
    });
  }

  private addMessage({ title, content }: Message, severity: string = 'success', key?: string) {
    this.messageService.add({
      severity,
      summary: title,
      detail: content,
      life: 3000,
      key
    });
  }

  private processImagePreview(url: string | null): void {
    if (url) {
      !this.renderableImageUrls.includes(url) &&
        this.http.head(url, { observe: 'response' }).subscribe((resp) => {
          if (resp.status === 200 && resp.headers.get('Content-Type')?.startsWith('image')) {
            this.renderableImageUrls.push(url);
          }
        });
    }
  }

  private emptyArtist(): Artist {
    return {
      id: null,
      urn: null,
      name: null,
      isPublic: false,
      description: null,
      biography: null,
      nationalityIsoCode: null,
      thumbnailUrl: null,
      backgroundUrl: null,
      revisionNumber: -1,
      isReleased: false,
      isVerified: false,
      refCode: null,
      createdAt: null,
      updatedAt: null,
      createdBy: null,
      updatedBy: null,
      tags: [],
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true
    };
  }

  private mapToArtist(artistDto: ArtistDto): Artist {
    const {
      id,
      urn,
      isPublic,
      revisionNumber,
      isReleased,
      isVerified,
      refCode,
      tags,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      profile: { name, description, biography, nationalityIsoCode, thumbnailUrl, backgroundUrl }
    } = artistDto;
    return {
      id,
      urn,
      isPublic,
      revisionNumber,
      isReleased,
      name,
      description,
      biography,
      nationalityIsoCode,
      thumbnailUrl,
      backgroundUrl,
      isVerified,
      refCode,
      tags,
      tagsString: tags.map(({ name }) => name).join(', '),
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true
    };
  }
}
