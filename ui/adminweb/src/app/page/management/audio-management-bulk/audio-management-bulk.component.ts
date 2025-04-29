import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Params, RouterModule } from '@angular/router';
import Papa from 'papaparse';
import { ConfirmationService, MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ConfirmPopupModule } from 'primeng/confirmpopup';
import { DatePickerModule } from 'primeng/datepicker';
import { DialogModule } from 'primeng/dialog';
import { EditorModule } from 'primeng/editor';
import { FileSelectEvent, FileUploadModule } from 'primeng/fileupload';
import { FloatLabelModule } from 'primeng/floatlabel';
import { IconFieldModule } from 'primeng/iconfield';
import { ImageModule } from 'primeng/image';
import { InputIconModule } from 'primeng/inputicon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { MultiSelectModule } from 'primeng/multiselect';
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
import { ArtistDto } from '../../../dto/artist-dto';
import { MapTrackAudioDto, TrackDto } from '../../../dto/track-dto';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { Tag } from '../../../model/tag';
import { TrackAudio } from '../../../model/track';
import { ArtistService } from '../../../service/artist.service';
import { TrackService } from '../../../service/track.service';
import { UrlValidator } from '../../../validator/url.validator';

interface TrackCsvColumn {
  trackrefcode: string;
  filem3u8url: string;
  durationsecond: number;
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
  trackArtists: TrackArtist[];
  isThumbnailDialogShowed: boolean;
  audio: TrackAudio;
  formGroup: FormGroup | null;
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
  templateUrl: './audio-management-bulk.component.html',
  styleUrl: './audio-management-bulk.component.scss',
  providers: [MessageService, TrackService, ConfirmationService, UrlValidator]
})
export class AudioManagementBulkComponent implements OnInit {
  readonly I18N = {
    IS_PUBLIC_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`,
    IS_PUBLIC_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`,
    IS_VERIFIED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`,
    IS_VERIFIED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`,
    IS_RELEASED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`,
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`
  };
  readonly renderableImageUrls: string[] = [];
  readonly selectedTracks: Track[] = [];
  readonly tracks: WritableSignal<Track[]> = signal<Track[]>([]);
  readonly trackArtists: TrackArtist[] = [];
  readonly columns: Column[] = [];
  readonly isArtistsLoading: WritableSignal<boolean> = signal<boolean>(true);
  readonly isLoading = signal(false);
  readonly artistsMap: Map<string, Artist> = new Map<string, Artist>();
  readonly artistsRefCodeKeyMap: Map<string, Artist> = new Map<string, Artist>();
  readonly tracksRefCodeKeyMap: Map<string, Track> = new Map<string, Track>();

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

  handleCsvSelected(event: FileSelectEvent): void {
    const file = event.files[0];
    if (file) {
      this.isLoading.set(true);
      this.tracks.set([]);
      this.parseCsvFile(file);
    }
  }

  handleRemoveRow(rowIndex: number): void {
    this.tracks.update((artists) => artists.filter((_artist, index) => index !== rowIndex));
  }

  handleGlobalFilter(table: Table, event: Event) {
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

  handleBulkSaveTrackAudio(): void {
    this.isLoading.set(true);
    const mapTrackAudioDtos: MapTrackAudioDto[] = this.tracks().map(
      ({ id, audio }: Track) =>
        ({
          id,
          trackAudio: { ...audio }
        }) as MapTrackAudioDto
    );
    this.bulkMapTrackAudio(mapTrackAudioDtos);
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
      this.trackService.getAllTracks(false, false).subscribe((respDto) => {
        const trackDtos: TrackDto[] = respDto.data;
        const tracks: Track[] = trackDtos.map((trackDto) => this.mapToTrack(trackDto));
        tracks.forEach((track) => {
          track.trackArtists.forEach((ta) => {
            const artist = this.artistsMap.get(ta.artistId!);
            if (artist) {
              ta.artistName = artist.name;
              ta.artistRefCode = artist.refCode;
            }
          });
          track.refCode && this.tracksRefCodeKeyMap.set(track.refCode, track);
        });
        this.tracks.set([]);
        this.isLoading.set(false);
      });
    });
  }

  private createTrackFormGroup(track: Track) {
    const { audio } = track;

    // File M3U8 Form Control
    const fileM3u8UrlFormControl: FormControl = new FormControl<string>(audio?.fileM3u8Url || '');
    fileM3u8UrlFormControl.valueChanges.subscribe(
      (value: string) => !fileM3u8UrlFormControl.errors && (track.audio.fileM3u8Url = value)
    );

    // Duration second
    const durationSecondFormControl: FormControl = new FormControl<number>(0);
    durationSecondFormControl.valueChanges.subscribe(
      (value: number) => !durationSecondFormControl.errors && (track.audio.durationSecond = value)
    );

    track.formGroup = new FormGroup({ fileM3u8UrlFormControl, durationSecondFormControl });
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
        const track = this.tracksRefCodeKeyMap.get(trackImport['trackrefcode']);
        if (track) {
          track.audio = {
            fileM3u8Url: trackImport['filem3u8url'],
            fileKey: null,
            isActive: true,
            durationSecond: trackImport['durationsecond']
          };
          this.createTrackFormGroup(track);
          tracks.push(track);
        }
      },
      complete: (_results) => {
        this.tracks.set(tracks);
        this.isLoading.set(false);
      }
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

  private bulkMapTrackAudio(mapTrackAudioDtos: MapTrackAudioDto[]): void {
    this.trackService.bulkMapTrackAudio({ items: mapTrackAudioDtos }).subscribe((respDto) => {
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
      audio: {
        fileKey: null,
        fileM3u8Url: null,
        durationSecond: null,
        isActive: false
      },
      trackArtists: [],
      isThumbnailDialogShowed: false,
      formGroup: null
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
      audio: {
        durationSecond: null,
        fileKey: null,
        fileM3u8Url: null,
        isActive: false
      },
      tagsString: tags.map(({ name }) => name).join(', '),
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      trackArtists: trackDto.trackArtists.map((trackArtist) => ({
        artistId: trackArtist.artistId,
        artistRefCode: trackArtist.artistRefCode,
        artistName: null,
        isActive: trackArtist.isActive,
        isMainArtist: trackArtist.isMainArtist
      })),
      isThumbnailDialogShowed: false,
      formGroup: null
    };
  }
}
