import { CommonModule, formatDate } from '@angular/common';
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
import { DatePickerModule, DatePickerTypeView } from 'primeng/datepicker';
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
import { UNDEFINED, URL_REGEX } from '../../../constant/constant';
import { ArtistDto } from '../../../dto/artist-dto';
import { CreateTrackDto, TrackArtistDto, TrackDto, UpdateTrackDto } from '../../../dto/track-dto';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { Tag } from '../../../model/tag';
import { TrackService } from '../../../service/track.service';
import { UrlValidator } from '../../../validator/url.validator';
import { ArtistService } from './../../../service/artist.service';

type ActionType = 'import' | 'edit';

interface DateFormat {
  name: string;
  datePickerFormat: string;
  format: string;
  view: DatePickerTypeView;
}
interface TrackCsvColumn {
  name: string;
  ispublic: string;
  description: string;
  nationalityisocode: string;
  thumbnailurl: string;
  backgroundurl: string;
  refcode: string;
  tagsjson: string;
  artistrefcodes: string;
  officialreleaseddate: string;
}

interface Column {
  field: string;
  header: string;
  customExportHeader?: string;
}

interface TrackArtist {
  artistId: string | null;
  artistRefCode: string | null;
  artistName: string | null;
  isActive: boolean;
  isMainArtist: boolean;
}

interface Artist {
  id: string | null;
  urn: string | null;
  refCode: string | null;
  name: string | null;
  biography: string | null;
  thumbnailUrl: string | null;
  isVerified: boolean;
}

interface Track {
  id: string | null;
  urn: string | null;
  name: string | null;
  isPublic: boolean;
  officialReleasedDate: string | null;
  description: string | null;
  thumbnailUrl: string | null;
  revisionNumber: number;
  isReleased: boolean;
  refCode: string | null;
  tags: Tag[];
  tagsString?: string;
  createdAt: string | null;
  updatedAt: string | null;
  createdBy: string | null;
  updatedBy: string | null;
  tagFilterKeyword: string;
  tagFilterFoundExactMatch: boolean;
  trackArtists: TrackArtist[];
  filteredTrackArtists: TrackArtist[];
  isThumbnailDialogShowed: boolean;
  formGroup: FormGroup | null;
  officialReleasedDateFormat: DateFormat;
}

@Component({
  selector: 'app-track-management-bulk',
  imports: [
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
    RouterModule,
    ToggleSwitchModule,
    MultiSelectModule,
    FileUploadModule,
    ProgressSpinnerModule,
    DatePickerModule
  ],
  templateUrl: './track-management-bulk.component.html',
  styleUrl: './track-management-bulk.component.scss',
  providers: [MessageService, TrackService, ConfirmationService, UrlValidator]
})
export class TrackManagementBulkComponent implements OnInit {
  readonly I18N = {
    IS_PUBLIC_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`,
    IS_PUBLIC_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`,
    IS_VERIFIED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`,
    IS_VERIFIED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`,
    IS_RELEASED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`,
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`
  };
  readonly OFFICIAL_RELEASED_DATE_FORMATS: DateFormat[] = [
    { name: 'Full date', format: 'yyyy-MM-dd', datePickerFormat: 'yy-mm-dd', view: 'date' },
    { name: 'Month with year', format: 'yyyy-MM', datePickerFormat: 'yy-mm', view: 'month' },
    { name: 'Only year', format: 'yyyy', datePickerFormat: 'yy', view: 'year' }
  ];
  readonly UNDEFINED = UNDEFINED;
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
  readonly selectedTracks: Track[] = [];
  readonly tracks: WritableSignal<Track[]> = signal<Track[]>([]);
  readonly trackArtists: TrackArtist[] = [];
  readonly columns: Column[] = [];
  readonly isArtistsLoading: WritableSignal<boolean> = signal<boolean>(true);
  readonly isLoading = signal(false);
  readonly artistsMap: Map<string, Artist> = new Map<string, Artist>();
  readonly artistsRefCodeKeyMap: Map<string, Artist> = new Map<string, Artist>();
  action: ActionType = 'import';

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly messageService: MessageService,
    private readonly trackService: TrackService,
    private readonly http: HttpClient,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly confirmationService: ConfirmationService,
    private readonly artistService: ArtistService,
    readonly formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {
    this.loadData();
  }

  handleTagFilter(event: MultiSelectFilterEvent, track: Track) {
    const tags = track.tags;
    const tagName = event.filter;
    track.tagFilterKeyword = tagName;
    if (tagName?.trim()) {
      track.tagFilterFoundExactMatch = tags.some(({ name }) => name === tagName);
    } else {
      track.tagFilterFoundExactMatch = true;
    }
  }

  handleCreateTag(track: Track): void {
    if (track.tagFilterKeyword?.trim()) {
      const tagName: string = track.tagFilterKeyword;
      const tags = track.tags;
      if (!tags.some(({ name }) => name === tagName)) {
        track.tags.push({ name: tagName, isActive: false });
        track.tagFilterKeyword = '';
        track.tagFilterFoundExactMatch = true;
      }
    }
  }

  handleCsvSelected(event: FileSelectEvent): void {
    const file = event.files[0];
    if (file) {
      this.isLoading.set(true);
      this.tracks.set([]);
      this.parseCsvFile(file);
      this.action = 'import';
    }
  }

  handleRemoveRow(rowIndex: number): void {
    this.tracks.update((artists) => artists.filter((_artist, index) => index !== rowIndex));
  }

  handleGlobalFilter(table: Table, event: Event) {
    console.log((event.target as HTMLInputElement).value);
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }

  handleEditThumbnail(track: Track): void {
    track.isThumbnailDialogShowed = true;
  }

  handleThumbnailDialogClose(track: Track, isChanged: boolean = false): void {
    const thumbnailUrlFormControl: FormControl | null = track.formGroup?.get(
      'thumbnailUrlFormControl'
    ) as FormControl<string>;
    if (thumbnailUrlFormControl) {
      if (isChanged) {
        track.thumbnailUrl = !thumbnailUrlFormControl.errors && thumbnailUrlFormControl.value;
      } else {
        thumbnailUrlFormControl.setValue(track.thumbnailUrl);
      }
    }
    track.isThumbnailDialogShowed = false;
  }

  handleBulkSaveArtist(): void {
    this.isLoading.set(true);
    if (this.action === 'edit') {
      const updateTrackDtos: UpdateTrackDto[] = this.tracks().map(
        ({ id, name, isPublic, description, thumbnailUrl, refCode, tags, trackArtists, officialReleasedDate }: Track) =>
          ({
            id,
            refCode,
            isPublic,
            tags,
            detail: { name, description, thumbnailUrl, officialReleasedDate },
            trackArtists: trackArtists.map((trackArtist) => ({ ...trackArtist }) as TrackArtistDto)
          }) as UpdateTrackDto
      );
      this.bulkUpdateTrack(updateTrackDtos);
    } else if (this.action === 'import') {
      const createTrackDtos: CreateTrackDto[] = this.tracks().map(
        ({ name, isPublic, description, thumbnailUrl, refCode, tags, trackArtists, officialReleasedDate }: Track) =>
          ({
            refCode,
            isPublic,
            tags,
            detail: { name, description, thumbnailUrl, officialReleasedDate },
            trackArtists: trackArtists.map((trackArtist) => ({ ...trackArtist }) as TrackArtistDto)
          }) as CreateTrackDto
      );
      this.bulkCreateTrack(createTrackDtos);
    }
  }

  private loadData(): void {
    this.isLoading.set(true);
    this.isArtistsLoading.set(true);
    // Load all artists first
    this.artistService.getAllArtists().subscribe((respDto) => {
      const artistDtos: ArtistDto[] = respDto.data.filter((artistDto) => artistDto != null);
      this.trackArtists.length = 0;
      const trackArtists = artistDtos.map((artistDto) => this.mapToTrackArtist(artistDto));
      this.trackArtists.push(...trackArtists);

      this.artistsMap.clear();
      this.artistsRefCodeKeyMap.clear();
      const artists = artistDtos.map((artistDto) => this.mapToArtist(artistDto));

      artists.forEach((artist) => artist.id && this.artistsMap.set(artist.id, artist));
      artists.forEach((artist) => artist.refCode && this.artistsRefCodeKeyMap.set(artist.refCode, artist));

      this.isArtistsLoading.set(false);
      this.listenAndProcessActiveRouteParams();
    });
  }

  private createTrackFormGroup(track: Track) {
    const { name, thumbnailUrl, description, tags, refCode, isPublic, trackArtists } = track;

    // Name
    const nameFormControl: FormControl = new FormControl<string>(name || '', [
      Validators.required,
      Validators.maxLength(250)
    ]);
    nameFormControl.valueChanges.subscribe((value: string) => !nameFormControl.errors && (track.name = value));

    // Track artists
    const trackArtistsFormControl: FormControl = new FormControl<TrackArtist[]>([...trackArtists.reverse()]);
    trackArtistsFormControl.valueChanges.subscribe(
      (values: TrackArtist[]) => !trackArtistsFormControl.errors && (track.trackArtists = values)
    );

    // Thumbnail URL
    const thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
    thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !thumbnailUrlFormControl.errors && ((track.thumbnailUrl = value), this.processImagePreview(value))
    );
    thumbnailUrlFormControl.setValue(thumbnailUrl);

    // Description
    const descriptionFormControl: FormControl = new FormControl<string>(description || '');
    descriptionFormControl.valueChanges.subscribe(
      (value: string) => !descriptionFormControl.errors && (track.description = value)
    );

    // Reference code
    const refCodeFormControl: FormControl = new FormControl<string>(refCode || '');
    track.revisionNumber > -1 && refCodeFormControl.disable();
    refCodeFormControl.valueChanges.subscribe((value: string) => !refCodeFormControl.errors && (track.refCode = value));

    // Public
    const isPublicFormControl: FormControl = new FormControl<boolean>(isPublic);
    isPublicFormControl.valueChanges.subscribe(
      (value: boolean) => !isPublicFormControl.errors && (track.isPublic = value)
    );

    // Official released date format
    const officialReleasedDateFormatFormControl: FormControl = new FormControl<DateFormat>(
      track.officialReleasedDateFormat
    );
    officialReleasedDateFormatFormControl.valueChanges.subscribe(
      (value: DateFormat) => !officialReleasedDateFormControl.errors && (track.officialReleasedDateFormat = value)
    );

    // Official released date
    const officialReleasedDateFormControl: FormControl = new FormControl<Date>(new Date());
    officialReleasedDateFormControl.valueChanges.subscribe(
      (value: Date) =>
        !officialReleasedDateFormControl.errors &&
        ((track.officialReleasedDate = formatDate(value, track.officialReleasedDateFormat.format, 'en-US')),
        console.log(track.officialReleasedDate))
    );

    // Tags
    const tagsFormControl: FormControl = new FormControl<Tag[]>(tags);
    tagsFormControl.valueChanges.subscribe(
      (values: string[]) =>
        !tagsFormControl.errors &&
        (track.tags = track.tags.map((tag) => ({
          ...tag,
          isActive: values.includes(tag.name)
        })))
    );
    tagsFormControl.setValue(
      tags.filter(({ isActive }) => isActive).map(({ name }) => name),
      { emitEvent: false }
    );

    track.formGroup = new FormGroup({
      trackArtistsFormControl,
      nameFormControl,
      officialReleasedDateFormatFormControl,
      officialReleasedDateFormControl,
      thumbnailUrlFormControl,
      descriptionFormControl,
      tagsFormControl,
      refCodeFormControl,
      isPublicFormControl
    });
  }
  private bulkUpdateTrack(updateTrackDtos: UpdateTrackDto[]): void {
    this.trackService.bulkUpdateTrack({ items: updateTrackDtos }).subscribe((respDto) => {
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

  private bulkCreateTrack(createTrackDtos: CreateTrackDto[]): void {
    this.trackService.bulkCreateTrack({ items: createTrackDtos }).subscribe((respDto) => {
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
    const tracks: Track[] = [];
    Papa.parse(file, {
      header: true,
      skipEmptyLines: true,
      quoteChar: '`',
      delimiter: ',',
      worker: true,
      step: (results) => {
        const trackImport = results.data as TrackCsvColumn;
        const trackArtists = ((JSON.parse(trackImport['artistrefcodes']) || []) as string[]).map((artistRefCode) => ({
          artistId: null,
          artistRefCode,
          artistName: this.artistsRefCodeKeyMap.get(artistRefCode)?.name || null,
          isActive: true,
          isMainArtist: false
        }));
        let officialReleasedDateFormat = this.OFFICIAL_RELEASED_DATE_FORMATS[0];
        const officialReleasedDate = trackImport['officialreleaseddate'];
        if (officialReleasedDate) {
          if (officialReleasedDate.length === 4) {
            officialReleasedDateFormat = this.OFFICIAL_RELEASED_DATE_FORMATS[2];
          } else if (officialReleasedDate.length === 7) {
            officialReleasedDateFormat = this.OFFICIAL_RELEASED_DATE_FORMATS[1];
          } else if (officialReleasedDate.length === 10) {
            officialReleasedDateFormat = this.OFFICIAL_RELEASED_DATE_FORMATS[0];
          }
        }
        const track: Track = {
          ...this.emptyTrack(),
          name: trackImport['name'] || null,
          isPublic: trackImport['ispublic'] === 'true',
          description: trackImport['description'] || null,
          thumbnailUrl: trackImport['thumbnailurl'] || null,
          refCode: trackImport['refcode'] || null,
          officialReleasedDateFormat: officialReleasedDateFormat,
          filteredTrackArtists: [...trackArtists],
          trackArtists,
          officialReleasedDate: officialReleasedDate,
          tags: trackImport['tagsjson']
            ? ((JSON.parse(trackImport['tagsjson']) || []) as string[]).map(
                (tag) => ({ name: tag, isActive: true }) as Tag
              )
            : []
        };
        this.createTrackFormGroup(track);
        tracks.push(track);
      },
      complete: (_results) => {
        this.tracks.set(tracks);
        this.isLoading.set(false);
      }
    });
  }
  private listenAndProcessActiveRouteParams(): void {
    this.activeRoute.queryParams.subscribe((queryParams: Params) => {
      if (queryParams['ids']) {
        this.action = 'edit';
        const ids: string[] = (queryParams['ids'] as string).split(',');

        // Load all tracks after loaded all artists
        this.trackService.getTrackByIds(ids, true, true).subscribe((respDto) => {
          const trackDtos: TrackDto[] = respDto.data.filter((track) => track !== null);
          this.tracks.set(
            trackDtos.map((trackDto) => {
              const track = this.mapToTrack(trackDto);
              track.filteredTrackArtists = this.trackArtists.slice(0, 100);
              track.filteredTrackArtists.push(...track.trackArtists);
              track.trackArtists.forEach((ta) => {
                const artist = this.artistsMap.get(ta.artistId!);
                if (artist) {
                  ta.artistName = artist.name;
                  ta.artistRefCode = artist.refCode;
                }
              });
              this.createTrackFormGroup(track);
              return track;
            })
          );
          this.isLoading.set(false);
        });
      }
      this.isLoading.set(false);
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
  private emptyTrack(): Track {
    return {
      id: null,
      urn: null,
      name: null,
      isPublic: false,
      officialReleasedDate: null,
      description: null,
      thumbnailUrl: null,
      revisionNumber: -1,
      isReleased: false,
      refCode: null,
      tags: [],
      tagsString: '',
      createdAt: null,
      updatedAt: null,
      createdBy: null,
      updatedBy: null,
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true,
      trackArtists: [],
      filteredTrackArtists: [],
      isThumbnailDialogShowed: false,
      formGroup: null,
      officialReleasedDateFormat: this.OFFICIAL_RELEASED_DATE_FORMATS[0]
    };
  }
  private mapToArtist(artistDto: ArtistDto): Artist {
    const {
      id,
      urn,
      refCode,
      profile: { name, biography, thumbnailUrl },
      isVerified
    } = artistDto;
    return {
      id,
      urn,
      refCode,
      name,
      biography,
      thumbnailUrl,
      isVerified
    };
  }

  private mapToTrackArtist(artistDto: ArtistDto): TrackArtist {
    const {
      id,
      profile: { name },
      refCode
    } = artistDto;
    return {
      artistId: id,
      artistName: name,
      artistRefCode: refCode,
      isActive: false,
      isMainArtist: false
    };
  }

  private mapToTrack(trackDto: TrackDto): Track {
    const {
      id,
      urn,
      isPublic,
      revisionNumber,
      isReleased,
      refCode,
      tags,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      detail: { name, description, thumbnailUrl }
    } = trackDto;
    return {
      id,
      urn,
      isPublic,
      officialReleasedDate: null,
      revisionNumber,
      isReleased,
      name,
      description,
      thumbnailUrl,
      refCode,
      tags,
      tagsString: tags.map(({ name }) => name).join(', '),
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true,
      trackArtists: trackDto.trackArtists.map((trackArtist) => ({
        artistId: trackArtist.artistId,
        artistRefCode: trackArtist.artistRefCode,
        artistName: null,
        isActive: trackArtist.isActive,
        isMainArtist: trackArtist.isMainArtist
      })),
      filteredTrackArtists: [],
      isThumbnailDialogShowed: false,
      formGroup: null,
      officialReleasedDateFormat: this.OFFICIAL_RELEASED_DATE_FORMATS[0]
    };
  }
}
