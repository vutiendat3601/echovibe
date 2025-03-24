import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ConfirmationService, MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
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
import { ArtistNationality, URL_REGEX } from '../../../constant/constant';
import { ResponseDto } from '../../../dto/response-dto';
import { ArtistMapper } from '../../../mapper/artist-mapper';
import { Artist } from '../../../model/artist';
import { CommandResult } from '../../../model/command-result';
import { ArtistNationalityPipe } from '../../../pipe/artist-nationality.pipe';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ArtistService } from '../../../service/artist.service';
import { UrlValidator } from '../../../validator/url.validator';
import { ArtistDto, CreateArtistDto, DeleteArtistDto } from './../../../dto/artist-dto';
import { ExceptionHandler, Message } from './../../../exception/exception-handler';

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

@Component({
  selector: 'app-artist-management',
  imports: [
    ArtistNationalityPipe,
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
    InputIconModule
  ],
  templateUrl: './artist-management.component.html',
  styleUrl: './artist-management.component.scss',
  providers: [MessageService, ArtistService, ConfirmationService, UrlValidator]
})
export class ArtistManagementComponent implements OnInit {
  readonly I18N_IS_PUBLIC_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`;
  readonly I18N_IS_PUBLIC_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`;
  readonly I18N_IS_VERIFIED_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`;
  readonly I18N_IS_VERIFIED_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`;
  readonly I18N_IS_RELEASED_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`;
  readonly I18N_IS_RELEASED_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`;
  private readonly newArtistIds: Set<string> = new Set();
  readonly nameFormControl: FormControl = new FormControl<string>('', [Validators.required, Validators.maxLength(250)]);
  readonly descriptionFormControl: FormControl = new FormControl<string>('');
  readonly biographyFormControl: FormControl = new FormControl<string>('');
  readonly thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly backgroundUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly nationalityIsoCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly isVerifiedFormControl: FormControl = new FormControl<boolean>(false);
  readonly tagsFormControl: FormControl = new FormControl<string[]>([]);
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
    refCodeFormControl: this.refCodeFormControl
  });
  readonly artistNationalities: { code: string; name: string }[] = Object.keys(ArtistNationality).map((key) => ({
    code: key,
    name: `${ArtistNationality[key as keyof typeof ArtistNationality]}`
  }));
  readonly renderableImageUrls: string[] = [];
  readonly selectedArtists: Artist[] = [];
  readonly artists: WritableSignal<Artist[]> = signal<Artist[]>([]);
  private fetchNewArtistIntervalId: number = -1;
  private editArtistId: string | null = null;
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
    private readonly exceptionHandler: ExceptionHandler
  ) {}

  ngOnInit(): void {
    this.listenAndProcessArtistCreated();
    this.listenAndProcessFormControlValueChange();
    this.loadData();
  }

  handleHideArtistDialog(): void {
    this.isDialogShowed = false;
    this.isDialogFormSubmitted = false;
  }

  handleDeleteSelectedArtists(): void {}

  handleExportCsv(): void {}

  handleGlobalFilter(table: Table, event: Event) {
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }

  handleNewArtist(): void {
    this.editArtistId = null;
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
      refCode
    } = artist;
    this.nameFormControl.setValue(name);
    this.descriptionFormControl.setValue(description);
    this.biographyFormControl.setValue(biography);
    this.backgroundUrlFormControl.setValue(backgroundUrl);
    this.nationalityIsoCodeFormControl.setValue(nationalityIsoCode);
    this.thumbnailUrlFormControl.setValue(thumbnailUrl);
    this.refCodeFormControl.setValue(refCode);
    artist.isReleased && this.refCodeFormControl.disable();
    this.editArtistId = id;
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
        isVerified: false,
        tags: []
      };
      this.createArtist(createArtistDto);
    } else if (this.action === 'edit') {
    }
  }

  handleDeleteArtist({ id }: Artist): void {
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_DELETE:Are you sure you want to delete the selected Artist?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_DELETE:Confirm delete`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => this.deleteArtist({ id })
    });
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

  private deleteArtist(deleteArtistDto: DeleteArtistDto) {
    const { id } = deleteArtistDto;
    this.artistService.bulkDeleteArtist({ items: [deleteArtistDto] }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.artists.update((artists) => artists.filter((artist) => artist.id != id));
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

  private loadData() {
    this.artistService.getMockArtists().subscribe((respDto: ResponseDto<ArtistDto[]>) => {
      this.artists.set(respDto.data.map(this.artistMapper.mapToArtist));
    });
  }

  private listenAndProcessFormControlValueChange() {
    this.thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) => !this.thumbnailUrlFormControl.errors && this.processImagePreview(value)
    );
    this.backgroundUrlFormControl.valueChanges.subscribe(
      (value: string) => !this.backgroundUrlFormControl.errors && this.processImagePreview(value)
    );
  }

  private listenAndProcessArtistCreated() {
    this.artistService.artistCreatedId().subscribe((newArtistId) => {
      if (newArtistId) {
        this.newArtistIds.add(newArtistId);
        if (this.newArtistIds.size && this.fetchNewArtistIntervalId < 0) {
          const updateNewArtists = () => {
            const fetchNewArtists = this.artistService.getArtistByIds([...this.newArtistIds]).pipe(
              map((respDto) => {
                const artistDtos: ArtistDto[] = respDto.data;
                const newArtists: Artist[] = artistDtos
                  .filter((artistDto) => artistDto)
                  .map(this.artistMapper.mapToArtist);
                this.artists.update((artists) => [...newArtists, ...artists]);
                newArtists.forEach(({ id }) => this.newArtistIds.has(id) && this.newArtistIds.delete(id));
                return !this.newArtistIds.size;
              })
            );

            this.fetchNewArtistIntervalId = window.setTimeout(() => {
              fetchNewArtists.subscribe((isAllFetched) =>
                isAllFetched ? (this.fetchNewArtistIntervalId = -1) : updateNewArtists()
              );
            }, 1_000);
          };
          updateNewArtists();
        }
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

  private processImagePreview(url: string): void {
    !this.renderableImageUrls.includes(url) &&
      this.http.head(url, { observe: 'response' }).subscribe((resp) => {
        if (resp.status === 200 && resp.headers.get('Content-Type')?.startsWith('image')) {
          this.renderableImageUrls.push(url);
        }
      });
  }
}
