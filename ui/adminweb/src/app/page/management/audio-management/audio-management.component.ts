import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ConfirmationService, FilterService, MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { CheckboxModule } from 'primeng/checkbox';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ConfirmPopupModule } from 'primeng/confirmpopup';
import { DatePickerModule } from 'primeng/datepicker';
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
import { MultiSelectModule } from 'primeng/multiselect';
import { PanelModule } from 'primeng/panel';
import { PopoverModule } from 'primeng/popover';
import { RadioButtonModule } from 'primeng/radiobutton';
import { RatingModule } from 'primeng/rating';
import { RippleModule } from 'primeng/ripple';
import { SelectModule } from 'primeng/select';
import { TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { ToastModule } from 'primeng/toast';
import { ToolbarModule } from 'primeng/toolbar';
import { URL_REGEX } from '../../../constant/constant';
import { ArtistDto } from '../../../dto/artist-dto';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { CommandResult } from '../../../model/command-result';
import { Tag } from '../../../model/tag';
import { TrackAudio } from '../../../model/track';
import { ArtistService } from '../../../service/artist.service';
import { TrackService } from '../../../service/track.service';
import { MapTrackAudioDto, ReleaseTrackDto, TrackDto } from './../../../dto/track-dto';

interface Column {
  field: string;
  header: string;
  exportHeader: string | null;
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

interface TrackArtist {
  artistId: string | null;
  artistRefCode: string | null;
  artistName: string | null;
  isActive: boolean;
  isMainArtist: boolean;
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
  audio: TrackAudio | null;
  trackArtists: TrackArtist[];
}

@Component({
  selector: 'app-track-management',
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
    ToastModule,
    ConfirmPopupModule,
    DatePickerModule,
    IconFieldModule,
    InputIconModule,
    RouterModule,
    CheckboxModule,
    PopoverModule,
    MultiSelectModule,
    InputGroupModule,
    InputGroupAddonModule,
    InputNumberModule
    // SafeHtmlPipe,
  ],
  templateUrl: './audio-management.component.html',
  styleUrl: './audio-management.component.scss',
  providers: [MessageService, ConfirmationService, TrackService, FilterService]
})
export class AudioManagementComponent implements OnInit {
  readonly I18N = {
    IS_PUBLIC_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`,
    IS_PUBLIC_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`,
    IS_VERIFIED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`,
    IS_VERIFIED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`,
    IS_RELEASED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`,
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`
  };
  readonly filteredTrackArtists: TrackArtist[] = [];
  readonly trackArtists: TrackArtist[] = [];
  readonly artistsMap: Map<string, Artist> = new Map<string, Artist>();
  readonly isArtistsLoading: WritableSignal<boolean> = signal<boolean>(true);
  currentTrack: Track = this.emptyTrack();
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
  readonly fileM3u8UrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly durationSecondFormControl: FormControl = new FormControl<number>(0);
  readonly trackFormGroup: FormGroup = new FormGroup({
    fileM3u8UrlFormControl: this.fileM3u8UrlFormControl,
    durationSecondFormControl: this.durationSecondFormControl
  });
  isDialogFormSubmitted: boolean = false;
  isDialogShowed: boolean = false;
  readonly renderableImageUrls: string[] = [];
  readonly selectedTracks: Track[] = [];
  readonly tracks: WritableSignal<Track[]> = signal<Track[]>([]);
  readonly isLoading: WritableSignal<boolean> = signal<boolean>(false);

  constructor(
    private readonly messageService: MessageService,
    private readonly confirmationService: ConfirmationService,
    private readonly trackService: TrackService,
    private readonly artistService: ArtistService,
    private readonly filterService: FilterService,
    private readonly http: HttpClient,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    this.loadData();
    this.listenAndProcessFormControlValueChange();
    this.listenAndProcessTrackEvents();
  }

  handleHideTrackAudioDialog(): void {
    this.isDialogShowed = false;
    this.isDialogFormSubmitted = false;
  }

  handleImportCsv(): void {
    this.router.navigate(['/management/audio/bulk']);
  }

  handleSaveTrackAudio(): void {
    if (this.currentTrack.id && this.currentTrack.audio) {
      const mapTrackAudioDto: MapTrackAudioDto = {
        id: this.currentTrack.id,
        trackAudio: {
          ...this.currentTrack.audio
        }
      };
      this.mapTrackAudio(mapTrackAudioDto);
    }
  }

  handleEditTrackAudio(track: Track): void {
    this.currentTrack = track;
    const { audio } = this.currentTrack;
    audio ? this.fileM3u8UrlFormControl.setValue(audio.fileM3u8Url) : this.fileM3u8UrlFormControl.reset();
    this.isDialogFormSubmitted = false;
    this.isDialogShowed = true;
  }

  private loadData(): void {
    this.isLoading.set(true);
    this.isArtistsLoading.set(true);

    // Load all artists first
    this.artistService.getAllArtists().subscribe((respDto) => {
      this.trackArtists.length = 0;
      const trackArtists = respDto.data.map((artistDto) => this.mapToTrackArtist(artistDto));
      this.trackArtists.push(...trackArtists);
      this.filteredTrackArtists.length = 0;
      this.filteredTrackArtists.push(...trackArtists.slice(0, 100));

      this.artistsMap.clear();
      const artists = respDto.data.map((artistDto) => this.mapToArtist(artistDto));
      artists.forEach((artist) => artist.id && this.artistsMap.set(artist.id, artist));
      this.isArtistsLoading.set(false);

      // Load all tracks after loaded all artists
      this.trackService.getAllTracks(true, true).subscribe((respDto) => {
        this.tracks.set(
          respDto.data.map((trackDto) => {
            const track = this.mapToTrack(trackDto);
            track.trackArtists.forEach((ta) => {
              const artist = this.artistsMap.get(ta.artistId!);
              if (artist) {
                ta.artistName = artist.name;
                ta.artistRefCode = artist.refCode;
              }
            });
            return track;
          })
        );
        this.isLoading.set(false);
      });
    });
  }

  private listenAndProcessFormControlValueChange() {
    // File M3U8 URL
    this.fileM3u8UrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !this.fileM3u8UrlFormControl.errors && this.currentTrack.audio && (this.currentTrack.audio.fileM3u8Url = value)
    );

    this.durationSecondFormControl.valueChanges.subscribe(
      (value: number) =>
        !this.fileM3u8UrlFormControl.errors &&
        this.currentTrack.audio &&
        (this.currentTrack.audio.durationSecond = value)
    );
  }

  private listenAndProcessTrackEvents() {
    this.trackService.changedTracksEvent.subscribe((trackDtos) => {
      const updatedTracksMap: Map<string, Track> = new Map(
        trackDtos.map((trackDto) => {
          const track = this.mapToTrack(trackDto);
          track.trackArtists.forEach((ta) => {
            const artist = this.artistsMap.get(ta.artistId!);
            if (artist) {
              ta.artistName = artist.name;
              ta.artistRefCode = artist.refCode;
            }
          });
          return [trackDto.id, track];
        })
      );
      const renderedIds: string[] = this.tracks()
        .filter((id) => id)
        .map(({ id }) => id) as string[];
      this.tracks.update((tracks) => {
        return [
          ...Array.from(updatedTracksMap.values()).filter(({ id }) => id && !renderedIds.includes(id)),
          ...tracks.map((artist) => (artist.id && updatedTracksMap.get(artist.id)) || artist)
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

  private mapTrackAudio(updateTrackDto: MapTrackAudioDto): void {
    this.trackService.bulkMapTrackAudio({ items: [updateTrackDto] }).subscribe((respDto) => {
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

  private releaseTrack(releaseTrackDto: ReleaseTrackDto): void {
    this.trackService.bulkReleaseTrack({ items: [releaseTrackDto] }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_TRACK_RELEASED_SUCCESSFUL:Bulk release Artist request was processed successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
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
      audio: {
        fileKey: null,
        fileM3u8Url: null,
        isActive: false,
        durationSecond: null
      },
      refCode: null,
      createdAt: null,
      updatedAt: null,
      createdBy: null,
      updatedBy: null,
      tags: [],
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true,
      trackArtists: []
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
      detail: { name, description, thumbnailUrl, officialReleasedDate },
      audio
    } = trackDto;
    return {
      id,
      urn,
      isPublic,
      officialReleasedDate,
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
      audio: audio || { fileKey: null, fileM3u8Url: null, isActive: false, durationSecond: null },
      trackArtists: trackDto.trackArtists.map((trackArtist) => ({
        artistId: trackArtist.artistId,
        artistRefCode: trackArtist.artistRefCode,
        artistName: null,
        isActive: trackArtist.isActive,
        isMainArtist: trackArtist.isMainArtist
      }))
    };
  }
}
