import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Params, RouterModule } from '@angular/router';
import Papa from 'papaparse';
import { ConfirmationService, MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ConfirmPopupModule } from 'primeng/confirmpopup';
import { DialogModule } from 'primeng/dialog';
import { EditorModule } from 'primeng/editor';
import { FileSelectEvent, FileUploadModule } from 'primeng/fileupload';
import { FloatLabelModule } from 'primeng/floatlabel';
import { IconFieldModule } from 'primeng/iconfield';
import { ImageModule } from 'primeng/image';
import { InputIconModule } from 'primeng/inputicon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { MultiSelectFilterEvent, MultiSelectModule } from 'primeng/multiselect';
import { PanelModule } from 'primeng/panel';
import { ProgressSpinnerModule } from 'primeng/progressspinner';
import { RadioButtonModule } from 'primeng/radiobutton';
import { RatingModule } from 'primeng/rating';
import { RippleModule } from 'primeng/ripple';
import { SelectModule } from 'primeng/select';
import { Table, TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { ToastModule } from 'primeng/toast';
import { ToggleSwitchModule } from 'primeng/toggleswitch';
import { ToolbarModule } from 'primeng/toolbar';
import { ARTIST_NATIONALITIES, UNDEFINED, URL_REGEX } from '../../../constant/constant';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { Nationality } from '../../../model/nationality';
import { Tag } from '../../../model/tag';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ArtistService } from '../../../service/artist.service';
import { UrlValidator } from '../../../validator/url.validator';
import { ArtistDto, CreateArtistDto, UpdateArtistDto } from './../../../dto/artist-dto';
import { ArtistNationalityNamePipe } from './../../../pipe/artist-nationality.pipe';

interface ArtistImportCsvColumn {
  name: string;
  ispublic: string;
  description: string;
  biography: string;
  nationalityisocode: string;
  thumbnailurl: string;
  backgroundurl: string;
  refcode: string;
  tagsjson: string;
}

interface Column {
  field: string;
  header: string;
  customExportHeader?: string;
}

type ActionType = 'import' | 'edit';

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
  tagsString: string;
  tagFilterKeyword: string;
  tagFilterFoundExactMatch: boolean;
  isBackgroundDialogShowed: boolean;
  isThumbnailDialogShowed: boolean;
  isBiographyDialogShowed: boolean;
  formGroup: FormGroup | null;
}

@Component({
  selector: 'app-artist-management-bulk',
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
    ConfirmPopupModule,
    SafeHtmlPipe,
    RouterModule,
    ToggleSwitchModule,
    MultiSelectModule,
    FileUploadModule,
    ProgressSpinnerModule
  ],
  templateUrl: './artist-management-bulk.component.html',
  styleUrl: './artist-management-bulk.component.scss',
  providers: [MessageService, ArtistService, ConfirmationService, UrlValidator]
})
export class ArtistManagementBulkComponent implements OnInit {
  private readonly MAX_NUMBER_OF_ROWS = 50;
  private readonly ARTIST_IMPORT_CSV_CHUNK_PREFIX = 'importArtistCsv_chunk_';

  readonly I18N = {
    IS_PUBLIC_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`,
    IS_PUBLIC_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`,
    IS_VERIFIED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`,
    IS_VERIFIED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`,
    IS_RELEASED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`,
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`
  };

  // Constants
  readonly UNDEFINED = UNDEFINED;
  readonly artistNationalities: Nationality[] = ARTIST_NATIONALITIES;
  readonly IS_PUBLIC_OPTIONS: { name: string; value: boolean }[] = [
    {
      name: this.I18N.IS_PUBLIC_TRUE,
      value: true
    },
    {
      name: this.I18N.IS_PUBLIC_FALSE,
      value: false
    }
  ];

  readonly renderableImageUrls: string[] = [];
  readonly selectedArtists: Artist[] = [];
  readonly artists: WritableSignal<Artist[]> = signal<Artist[]>([]);
  readonly columns: Column[] = [];
  readonly isLoading = signal(false);
  action: ActionType = 'import';

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly messageService: MessageService,
    private readonly confirmationService: ConfirmationService,
    private readonly artistService: ArtistService,
    private readonly http: HttpClient,
    private readonly exceptionHandler: ExceptionHandler,
    readonly formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {
    this.listenAndProcessActiveRouteParams();
  }

  handleTagFilter(event: MultiSelectFilterEvent, artist: Artist) {
    const tags = artist.tags;
    const tagName = event.filter;
    artist.tagFilterKeyword = tagName;
    if (tagName?.trim()) {
      artist.tagFilterFoundExactMatch = tags.some(({ name }) => name === tagName);
    } else {
      artist.tagFilterFoundExactMatch = true;
    }
  }

  handleCreateTag(artist: Artist): void {
    if (artist.tagFilterKeyword?.trim()) {
      const tagName: string = artist.tagFilterKeyword;
      const tags = artist.tags;
      if (!tags.some(({ name }) => name === tagName)) {
        artist.tags.push({ name: tagName, isActive: false });
        artist.tagFilterKeyword = '';
        artist.tagFilterFoundExactMatch = true;
      }
    }
  }

  handleCsvSelected(event: FileSelectEvent): void {
    const file = event.files[0];
    if (file) {
      this.isLoading.set(true);
      this.artists.set([]);
      this.parseCsvFile(file);
      this.action = 'import';
    }
  }
  handleRemoveRow(rowIndex: number): void {
    this.artists.update((artists) => artists.filter((_artist, index) => index !== rowIndex));
  }

  handleGlobalFilter(table: Table, event: Event) {
    console.log((event.target as HTMLInputElement).value);
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }

  handleEditThumbnail(artist: Artist): void {
    artist.isThumbnailDialogShowed = true;
  }

  handleEditBackground(artist: Artist): void {
    artist.isBackgroundDialogShowed = true;
  }

  handleEditBiography(artist: Artist): void {
    artist.isBiographyDialogShowed = true;
  }

  handleThumbnailDialogClose(artist: Artist, isChanged: boolean = false): void {
    const thumbnailUrlFormControl: FormControl | null = artist.formGroup?.get(
      'thumbnailUrlFormControl'
    ) as FormControl<string>;
    if (thumbnailUrlFormControl) {
      if (isChanged) {
        artist.thumbnailUrl = !thumbnailUrlFormControl.errors && thumbnailUrlFormControl.value;
      } else {
        thumbnailUrlFormControl.setValue(artist.thumbnailUrl);
      }
    }
    artist.isThumbnailDialogShowed = false;
  }

  handleBackgroundDialogClose(artist: Artist, isChanged: boolean = false): void {
    const backgroundUrlFormControl: FormControl | null = artist.formGroup?.get(
      'backgroundUrlFormControl'
    ) as FormControl<string>;
    if (backgroundUrlFormControl) {
      if (isChanged) {
        artist.backgroundUrl = !backgroundUrlFormControl.errors && backgroundUrlFormControl.value;
      } else {
        backgroundUrlFormControl.setValue(artist.backgroundUrl);
      }
    }
    artist.isThumbnailDialogShowed = false;
  }

  handleBiographyDialogClose(artist: Artist, isChanged: boolean = false): void {
    const biographyFormControl: FormControl | null = artist.formGroup?.get(
      'biographyFormControl'
    ) as FormControl<string>;
    if (biographyFormControl) {
      if (isChanged) {
        artist.biography = !biographyFormControl.errors && biographyFormControl.value;
      } else {
        biographyFormControl.setValue(artist.biography);
      }
    }
    artist.isBiographyDialogShowed = false;
  }

  handleBulkSaveArtist(): void {
    this.isLoading.set(true);
    if (this.action === 'edit') {
      const updateArtistDtos: UpdateArtistDto[] = this.artists().map(
        ({
          id,
          name,
          isPublic,
          description,
          biography,
          nationalityIsoCode,
          thumbnailUrl,
          backgroundUrl,
          refCode,
          tags
        }: Artist) =>
          ({
            id,
            refCode,
            isPublic,
            tags,
            profile: { name, description, biography, nationalityIsoCode, thumbnailUrl, backgroundUrl }
          }) as UpdateArtistDto
      );
      this.bulkUpdateArtist(updateArtistDtos);
    } else if (this.action === 'import') {
      const createArtistDtos: CreateArtistDto[] = this.artists().map(
        ({
          name,
          isPublic,
          description,
          biography,
          nationalityIsoCode,
          thumbnailUrl,
          backgroundUrl,
          refCode,
          tags
        }: Artist) =>
          ({
            refCode,
            isPublic,
            tags,
            profile: { name, description, biography, nationalityIsoCode, thumbnailUrl, backgroundUrl }
          }) as CreateArtistDto
      );
      this.bulkCreateArtist(createArtistDtos);
    }
  }

  private createArtistFormGroup(artist: Artist) {
    const { name, thumbnailUrl, nationalityIsoCode, backgroundUrl, description, biography, tags, refCode, isPublic } =
      artist;

    // Name
    const nameFormControl: FormControl = new FormControl<string>(name || '', [
      Validators.required,
      Validators.maxLength(250)
    ]);
    nameFormControl.valueChanges.subscribe((value: string) => !nameFormControl.errors && (artist.name = value));

    // Nationality
    const nationalityIsoCodeFormControl: FormControl = new FormControl<string>(nationalityIsoCode || UNDEFINED);
    nationalityIsoCodeFormControl.valueChanges.subscribe(
      (value: string) => !nationalityIsoCodeFormControl.errors && (artist.nationalityIsoCode = value)
    );

    // Thumbnail URL
    const thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
    thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !thumbnailUrlFormControl.errors && ((artist.thumbnailUrl = value), this.processImagePreview(value))
    );
    thumbnailUrlFormControl.setValue(thumbnailUrl);

    // Background URL
    const backgroundUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
    backgroundUrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !backgroundUrlFormControl.errors && ((artist.backgroundUrl = value), this.processImagePreview(value))
    );
    backgroundUrlFormControl.setValue(backgroundUrl);

    // Description
    const descriptionFormControl: FormControl = new FormControl<string>(description || '');
    descriptionFormControl.valueChanges.subscribe(
      (value: string) => !descriptionFormControl.errors && (artist.description = value)
    );

    // Biography
    const biographyFormControl: FormControl = new FormControl<string>(biography || '');
    biographyFormControl.valueChanges.subscribe(
      (value: string) => !biographyFormControl.errors && (artist.biography = value)
    );

    // Reference code
    const refCodeFormControl: FormControl = new FormControl<string>(refCode || '');
    artist.revisionNumber > -1 && refCodeFormControl.disable();
    refCodeFormControl.valueChanges.subscribe(
      (value: string) => !refCodeFormControl.errors && (artist.refCode = value)
    );

    // Public
    const isPublicFormControl: FormControl = new FormControl<boolean>(isPublic);
    isPublicFormControl.valueChanges.subscribe(
      (value: boolean) => !isPublicFormControl.errors && (artist.isPublic = value)
    );

    // Tags
    const tagsFormControl: FormControl = new FormControl<Tag[]>(tags);
    tagsFormControl.valueChanges.subscribe(
      (values: string[]) =>
        !tagsFormControl.errors &&
        (artist.tags = artist.tags.map((tag) => ({
          ...tag,
          isActive: values.includes(tag.name)
        })))
    );
    tagsFormControl.setValue(
      tags.filter(({ isActive }) => isActive).map(({ name }) => name),
      { emitEvent: false }
    );

    artist.formGroup = new FormGroup({
      nameFormControl,
      thumbnailUrlFormControl,
      backgroundUrlFormControl,
      nationalityIsoCodeFormControl,
      descriptionFormControl,
      biographyFormControl,
      tagsFormControl,
      refCodeFormControl,
      isPublicFormControl
    });
  }
  private bulkUpdateArtist(updateArtistDtos: UpdateArtistDto[]): void {
    this.artistService.bulkUpdateArtist({ items: updateArtistDtos }).subscribe((respDto) => {
      this.isLoading.set(false);
      respDto.data.items.forEach(({ isSuccessful, errors, id }) => {
        if (isSuccessful) {
          this.addMessage({
            title: $localize`:@@TITLE_SUCCESS:Success`,
            content: `ID: ${id}. ` + $localize`:@@MESSAGE_ARTIST_UPDATED_SUCCESSFUL:`
          });
        } else {
          const message = this.exceptionHandler.handle(errors[0]);
          message.content = `ID: ${id}. ` + message.content;
          this.addMessage(message, 'error');
        }
      });
    });
  }

  private bulkCreateArtist(createArtistDtos: CreateArtistDto[]): void {
    this.artistService.bulkCreateArtist({ items: createArtistDtos }).subscribe((respDto) => {
      this.isLoading.set(false);
      respDto.data.items.forEach(({ isSuccessful, errors, id }) => {
        if (isSuccessful) {
          this.addMessage({
            title: $localize`:@@TITLE_SUCCESS:Success`,
            content: `ID: ${id}. ` + $localize`:@@MESSAGE_ARTIST_UPDATED_SUCCESSFUL:`
          });
        } else {
          const message = this.exceptionHandler.handle(errors[0]);
          message.content = `ID: ${id}. ` + message.content;
          this.addMessage(message, 'error');
        }
      });
    });
  }

  private parseCsvFile(file: File): void {
    const artists: Artist[] = [];
    Papa.parse(file, {
      header: true,
      skipEmptyLines: true,
      quoteChar: '`',
      delimiter: ',',
      worker: true,
      step: (results) => {
        const artistImport = results.data as ArtistImportCsvColumn;
        const artist: Artist = {
          ...this.emptyArtist(),
          name: artistImport['name'] || null,
          isPublic: artistImport['ispublic'] === 'true',
          description: artistImport['description'] || null,
          biography: artistImport['biography'] || null,
          nationalityIsoCode: artistImport['nationalityisocode'] || null,
          thumbnailUrl: artistImport['thumbnailurl'] || null,
          backgroundUrl: artistImport['backgroundurl'] || null,
          refCode: artistImport['refcode'] || null,
          tags: artistImport['tagsjson']
            ? ((JSON.parse(artistImport['tagsjson']) || []) as string[]).map(
                (tag) => ({ name: tag, isActive: true }) as Tag
              )
            : []
        };
        this.createArtistFormGroup(artist);
        artists.push(artist);
      },
      complete: (_results) => {
        this.artists.set(artists);
        this.isLoading.set(false);
      }
    });
  }
  private listenAndProcessActiveRouteParams(): void {
    this.activeRoute.queryParams.subscribe((queryParams: Params) => {
      if (queryParams['ids']) {
        const ids: string[] = (queryParams['ids'] as string).split(',');
        this.loadArtists(ids);
        this.action = 'edit';
      }
    });
  }

  private loadArtists(ids: string[]) {
    this.artistService.getArtistByIds(ids).subscribe((respDto) => {
      const artistDtos: ArtistDto[] = respDto.data.filter((artistDto) => artistDto != null);
      const artists = artistDtos.map((artistDto) => {
        const artist: Artist = this.mapToArtist(artistDto);
        this.createArtistFormGroup(artist);
        return artist;
      });
      this.artists.set(artists);
    });
  }

  private addMessage({ title, content }: Message, severity: string = 'success', key?: string) {
    this.messageService.add({
      severity,
      summary: title,
      detail: content,
      life: 10_000,
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
      tags: [],
      tagsString: '',
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true,
      formGroup: null,
      isBackgroundDialogShowed: false,
      isThumbnailDialogShowed: false,
      isBiographyDialogShowed: false
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
      profile: { name, description, biography, nationalityIsoCode, thumbnailUrl, backgroundUrl }
    } = artistDto;
    return {
      id,
      name,
      description,
      biography,
      thumbnailUrl,
      backgroundUrl,
      nationalityIsoCode,
      isPublic,
      isReleased,
      refCode,
      tags,
      tagsString: tags.map(({ name }) => name).join(', '),
      urn,
      revisionNumber,
      formGroup: null,
      isVerified,
      tagFilterFoundExactMatch: true,
      tagFilterKeyword: '',
      isBackgroundDialogShowed: false,
      isThumbnailDialogShowed: false,
      isBiographyDialogShowed: false
    };
  }
}
