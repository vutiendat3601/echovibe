import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ConfirmationService, MessageService } from 'primeng/api';
import { PopoverModule } from 'primeng/popover';
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
import { InputIconModule } from 'primeng/inputicon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { MultiSelectFilterEvent, MultiSelectModule } from 'primeng/multiselect';
import { PanelModule } from 'primeng/panel';
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
import { ArtistMapper } from '../../../mapper/artist-mapper';
import { Artist } from '../../../model/artist';
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
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';

type ActionType = 'new' | 'edit';

interface Column {
  field: string;
  header: string;
  customExportHeader?: string;
}

interface ExportColumn {
  title: string;
  dataKey: string;
}

interface ArtistAttribute {
  id: string | null;
  tags: Tag[];
  tagFilterKeyword: string | null;
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
  readonly UNDEFINED = UNDEFINED;
  readonly I18N_IS_PUBLIC_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`;
  readonly I18N_IS_PUBLIC_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`;
  readonly I18N_IS_VERIFIED_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`;
  readonly I18N_IS_VERIFIED_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`;
  readonly I18N_IS_RELEASED_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`;
  readonly I18N_IS_RELEASED_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`;
  private readonly changedArtistIds: Set<string> = new Set();
  currentArtistAttribute: ArtistAttribute = this.emptyArtistAttribute();
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
  private fetchArtistTimeoutId: number = -1;
  isDialogFormSubmitted: boolean = false;
  isDialogShowed: boolean = false;
  action: ActionType = 'new';
  readonly columns: Column[] = [];

  constructor(
    private readonly messageService: MessageService,
    private readonly confirmationService: ConfirmationService,
    private readonly artistService: ArtistService,
    private readonly http: HttpClient,
    private readonly artistMapper: ArtistMapper,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    this.listenAndProcessArtistEvent();
    this.listenAndProcessFormControlValueChange();
    this.loadData();
  }

  handleHideArtistDialog(): void {
    this.isDialogShowed = false;
    this.isDialogFormSubmitted = false;
  }

  handleDeleteSelectedArtists(): void {
    const deleteArtistDtos: DeleteArtistDto[] = this.selectedArtists.map(({ id }) => ({
      id
    }));
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_BULK_REQUEST_DELETE:Are you sure you want to delete the selected Artists?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_DELETE:Confirm delete`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => this.bulkDeleteArtist(deleteArtistDtos)
    });
  }

  handleReleaseSelectedArtists(): void {
    const releaseArtistDtos: ReleaseArtistDto[] = this.selectedArtists.map(({ id }) => ({
      id
    }));
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
    this.currentArtistAttribute = this.emptyArtistAttribute();
    this.refCodeFormControl.enable();
    if (this.action === 'edit' || this.isDialogFormSubmitted) {
      // These two cases: [The action is edit before, the Artist (create, edit) was saved]
      // We'll erase the data in the form.
      this.artistFormGroup.reset();
    }
    this.openArtistDialog('new');
  }

  handleEditArtist(artist: Artist): void {
    const {
      id,
      profile: { name, description, biography, thumbnailUrl, backgroundUrl, nationalityIsoCode },
      refCode,
      isPublic,
      tags
    } = artist;
    this.nameFormControl.setValue(name);
    this.descriptionFormControl.setValue(description);
    this.biographyFormControl.setValue(biography);
    this.backgroundUrlFormControl.setValue(backgroundUrl);
    this.nationalityIsoCodeFormControl.setValue(nationalityIsoCode);
    this.thumbnailUrlFormControl.setValue(thumbnailUrl);
    this.refCodeFormControl.setValue(refCode);
    this.isPublicFormControl.setValue(isPublic);
    artist.revisionNumber > -1 && this.refCodeFormControl.disable();
    this.tagsFormControl.setValue(tags.filter(({ isActive }) => isActive).map(({ name }) => name));
    this.currentArtistAttribute = { id, tags, tagFilterFoundExactMatch: true, tagFilterKeyword: null };

    this.openArtistDialog('edit');
  }

  handleSaveArtist(): void {
    if (this.action === 'new') {
      const createArtistDto: CreateArtistDto = {
        profile: {
          name: this.nameFormControl.value,
          description: this.descriptionFormControl.value,
          biography: this.biographyFormControl.value,
          nationalityIsoCode: this.nationalityIsoCodeFormControl.value || null,
          thumbnailUrl: this.thumbnailUrlFormControl.value || null,
          backgroundUrl: this.backgroundUrlFormControl.value || null
        },
        refCode: this.refCodeFormControl.value,
        isPublic: this.isPublicFormControl.value,
        tags: this.currentArtistAttribute.tags
      };
      this.createArtist(createArtistDto);
    } else if (this.action === 'edit') {
      if (this.currentArtistAttribute.id) {
        const updateArtistDto: UpdateArtistDto = {
          id: this.currentArtistAttribute.id,
          profile: {
            name: this.nameFormControl.value,
            description: this.descriptionFormControl.value,
            biography: this.biographyFormControl.value,
            nationalityIsoCode: this.nationalityIsoCodeFormControl.value || this.UNDEFINED,
            thumbnailUrl: this.thumbnailUrlFormControl.value,
            backgroundUrl: this.backgroundUrlFormControl.value
          },
          refCode: this.refCodeFormControl.value,
          isPublic: this.isPublicFormControl.value,
          tags: this.currentArtistAttribute.tags
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
    const tags = this.currentArtistAttribute.tags;
    const tagName = event.filter;
    this.currentArtistAttribute.tagFilterKeyword = tagName;
    if (tagName?.trim()) {
      this.currentArtistAttribute.tagFilterFoundExactMatch = tags.some(({ name }) => name === tagName);
    } else {
      this.currentArtistAttribute.tagFilterFoundExactMatch = true;
    }
  }

  handleCreateTag(): void {
    if (this.currentArtistAttribute.tagFilterKeyword?.trim()) {
      const tagName: string | null = this.currentArtistAttribute.tagFilterKeyword;
      const tags = this.currentArtistAttribute.tags;
      if (!tags.some(({ name }) => name === tagName)) {
        this.currentArtistAttribute.tags.push({ name: tagName, isActive: false });
        this.currentArtistAttribute.tagFilterKeyword = null;
        this.currentArtistAttribute.tagFilterFoundExactMatch = true;
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
          content: $localize`:@@MESSAGE_ARTIST_RELEASED_SUCCESSFUL:Bulk delete Artist request was processed successfully.`
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
    this.artistService.getMockArtists().subscribe((respDto: ResponseDto<[ArtistDto | null]>) => {
      this.artists.set(respDto.data.filter((artistDto) => artistDto != null).map(this.artistMapper.mapToArtist));
    });
  }

  private refreshData(): void {
    if (this.changedArtistIds.size && this.fetchArtistTimeoutId < 0) {
      const updateArtists = () => {
        const fetchNewArtists = this.artistService.getArtistByIds([...this.changedArtistIds]).pipe(
          map((respDto) => {
            const artistDtos: [ArtistDto | null] = respDto.data;
            const updatedArtists: Artist[] = artistDtos
              .filter((artistDto) => artistDto != null)
              .map(this.artistMapper.mapToArtist);
            const updatedArtistsMap: Map<string, Artist> = new Map(
              updatedArtists.map((updatedArtist) => [updatedArtist.id, updatedArtist])
            );
            this.artists.update((artists) => {
              const renderedIds: string[] = [...updatedArtistsMap.keys()];

              return [
                ...updatedArtists.filter(({ id }) => !renderedIds.includes(id)),
                ...artists.map((artist) => updatedArtistsMap.get(artist.id) || artist)
              ];
            });
            updatedArtists.forEach(({ id }) => this.changedArtistIds.has(id) && this.changedArtistIds.delete(id));
            return !this.changedArtistIds.size;
          })
        );

        this.fetchArtistTimeoutId = window.setTimeout(
          () => {
            fetchNewArtists.subscribe((isAllFetched) =>
              isAllFetched ? (this.fetchArtistTimeoutId = -1) : updateArtists()
            );
          },
          this.changedArtistIds.size >= 5 ? 5_000 : 1_000
        );
      };
      updateArtists();
    }
  }

  private listenAndProcessFormControlValueChange() {
    this.thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) => !this.thumbnailUrlFormControl.errors && this.processImagePreview(value)
    );
    this.backgroundUrlFormControl.valueChanges.subscribe(
      (value: string) => !this.backgroundUrlFormControl.errors && this.processImagePreview(value)
    );
    this.tagsFormControl.valueChanges.subscribe(
      (values: string[]) =>
        !this.backgroundUrlFormControl.errors &&
        (this.currentArtistAttribute.tags = this.currentArtistAttribute.tags.map((tag) => ({
          ...tag,
          isActive: values.includes(tag.name)
        })))
    );
  }

  private listenAndProcessArtistEvent() {
    this.artistService.artistCreatedEvent.subscribe((newArtistId) => {
      if (newArtistId) {
        this.changedArtistIds.add(newArtistId);
        this.refreshData();
      }
    });
    this.artistService.artistUpdatedEvent.subscribe((id) => {
      if (id) {
        this.changedArtistIds.add(id);
        this.refreshData();
      }
    });
    this.artistService.artistReleasedEvent.subscribe((id) => {
      if (id) {
        this.changedArtistIds.add(id);
        this.refreshData();
      }
    });
    this.artistService.artistDeletedEvent.subscribe((id) => {
      if (id) {
        this.artists.update((artists) => artists.filter((artist) => artist.id != id));
      }
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

  private emptyArtistAttribute(): ArtistAttribute {
    return {
      id: null,
      tags: [],
      tagFilterKeyword: null,
      tagFilterFoundExactMatch: true
    };
  }
}
