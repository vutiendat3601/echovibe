import { CommonModule, formatDate } from '@angular/common';
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
import { DatePickerModule, DatePickerTypeView } from 'primeng/datepicker';
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
import { ArtistService } from '../../../service/artist.service';
import { TrackService } from '../../../service/track.service';
import {
  CreateTrackDto,
  DeleteTrackDto,
  ReleaseTrackDto,
  TrackArtistDto,
  TrackDto,
  UpdateTrackDto
} from './../../../dto/track-dto';

type ActionType = 'new' | 'edit';

interface DateFormat {
  name: string;
  datePickerFormat: string;
  format: string;
  view: DatePickerTypeView;
}

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
    InputGroupAddonModule
    // SafeHtmlPipe,
  ],
  templateUrl: './track-management.component.html',
  styleUrl: './track-management.component.scss',
  providers: [MessageService, ConfirmationService, TrackService, FilterService]
})
export class TrackManagementComponent implements OnInit {
  readonly I18N = {
    IS_PUBLIC_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`,
    IS_PUBLIC_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`,
    IS_VERIFIED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_YES:Yes`,
    IS_VERIFIED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_VERIFIED_NO:No`,
    IS_RELEASED_TRUE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_YES:Yes`,
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`
  };
  readonly OFFICIAL_RELEASED_DATE_FORMATS: DateFormat[] = [
    { name: 'Full date', format: 'dd/MM/yyyy', datePickerFormat: 'dd/mm/yy', view: 'date' },
    { name: 'Month with year', format: 'MM/yyyy', datePickerFormat: 'mm/yy', view: 'month' },
    { name: 'Only year', format: 'yyyy', datePickerFormat: 'yy', view: 'year' }
  ];
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
  officialReleasedDateFormat: DateFormat = this.OFFICIAL_RELEASED_DATE_FORMATS[0];
  readonly officialReleasedDateFormatFormControl: FormControl = new FormControl<DateFormat>(
    this.officialReleasedDateFormat
  );
  readonly nameFormControl: FormControl = new FormControl<string>('', [Validators.required, Validators.maxLength(250)]);
  readonly descriptionFormControl: FormControl = new FormControl<string>('');
  readonly thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly isPublicFormControl: FormControl = new FormControl<boolean>(false);
  readonly tagsFormControl: FormControl = new FormControl<Tag[]>([]);
  readonly trackArtistsFormControl: FormControl = new FormControl<TrackArtist[]>([]);
  readonly officialReleasedDateFormControl: FormControl = new FormControl<Date>(new Date());
  readonly refCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly trackFormGroup: FormGroup = new FormGroup({
    nameFormControl: this.nameFormControl,
    descriptionFormControl: this.descriptionFormControl,
    thumbnailUrlFormControl: this.thumbnailUrlFormControl,
    tagsFormControl: this.tagsFormControl,
    refCodeFormControl: this.refCodeFormControl,
    isPublicFormControl: this.isPublicFormControl,
    officialReleasedDateFormControl: this.officialReleasedDateFormControl,
    officialReleasedDateFormatFormControl: this.officialReleasedDateFormatFormControl,
    trackArtistsFormControl: this.trackArtistsFormControl
  });
  isDialogFormSubmitted: boolean = false;
  isDialogShowed: boolean = false;
  readonly renderableImageUrls: string[] = [];
  readonly selectedTracks: Track[] = [];
  readonly tracks: WritableSignal<Track[]> = signal<Track[]>([]);
  action: ActionType = 'new';
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

  handleHideTrackDialog(): void {
    this.isDialogShowed = false;
    this.isDialogFormSubmitted = false;
  }

  handleImportCsv(): void {
    this.router.navigate(['/management/track/bulk']);
  }

  handleSaveTrack(): void {
    if (this.action === 'new') {
      const createTrackDto: CreateTrackDto = {
        detail: {
          name: this.currentTrack.name,
          description: this.currentTrack.description,
          thumbnailUrl: this.currentTrack.thumbnailUrl,
          officialReleasedDate: this.currentTrack.officialReleasedDate
        },
        trackArtists: this.currentTrack.trackArtists.map((ta) => ta as TrackArtistDto),
        refCode: this.currentTrack.refCode,
        isPublic: this.currentTrack.isPublic,
        tags: this.currentTrack.tags
      };
      this.createTrack(createTrackDto);
    } else if (this.action === 'edit') {
      if (this.currentTrack.id) {
        const updateArtistDto: UpdateTrackDto = {
          id: this.currentTrack.id,
          detail: {
            name: this.currentTrack.name,
            description: this.currentTrack.description,
            thumbnailUrl: this.currentTrack.thumbnailUrl,
            officialReleasedDate: this.currentTrack.officialReleasedDate
          },
          trackArtists: this.currentTrack.trackArtists.map((ta) => ta as TrackArtistDto),
          refCode: this.currentTrack.refCode,
          isPublic: this.currentTrack.isPublic,
          tags: this.currentTrack.tags
        };
        this.updateTrack(updateArtistDto);
      }
    }
  }

  handleNewTrack(): void {
    this.currentTrack = this.emptyTrack();
    this.refCodeFormControl.enable();
    if (this.action === 'edit' || this.isDialogFormSubmitted) {
      // These two cases: [The action is edit before, the Track (create, edit) was saved]
      // We'll erase the data in the form.
      this.trackFormGroup.reset();
    }
    this.openTrackDialog('new');
  }

  handleEditTrack(track: Track): void {
    this.currentTrack = track;
    const { name, description, thumbnailUrl, refCode, isPublic, tags, trackArtists } = this.currentTrack;
    this.nameFormControl.setValue(name);
    this.descriptionFormControl.setValue(description);
    this.thumbnailUrlFormControl.setValue(thumbnailUrl);
    this.refCodeFormControl.setValue(refCode);
    this.isPublicFormControl.setValue(isPublic);
    this.tagsFormControl.setValue(tags.filter(({ isActive }) => isActive).map(({ name }) => name));
    this.trackArtistsFormControl.setValue([...trackArtists]);
    this.filteredTrackArtists.push(...trackArtists);
    track.revisionNumber > -1 && this.refCodeFormControl.disable();
    this.openTrackDialog('edit');
  }

  handleEditSelectedArtists(): void {
    if (this.selectedTracks.length === 1) {
      this.handleEditTrack(this.selectedTracks[0]);
    } else if (this.selectedTracks.length > 1) {
      const ids = this.selectedTracks.map((track) => track.id).join(',');
      this.router.navigate(['/management/track/bulk'], { queryParams: { ids } });
    }
  }

  handleDeleteSelectedTracks(): void {
    const deleteTrackDtos: DeleteTrackDto[] = this.selectedTracks.map(
      ({ id }) =>
        ({
          id
        }) as DeleteTrackDto
    );
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_TRACK_BULK_REQUEST_DELETE:Are you sure you want to delete the selected Artists?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_DELETE:Confirm delete`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => this.bulkDeleteTrack(deleteTrackDtos)
    });
  }

  handleDeleteArtist({ id }: Artist): void {
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_TRACK_DELETE:Are you sure you want to delete the selected Track?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_DELETE:Confirm delete`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => id && this.deleteTrack({ id })
    });
  }

  handleReleaseSelectedArtists(): void {
    const releaseTrackDtos: ReleaseTrackDto[] = this.selectedTracks.map(
      ({ id }) =>
        ({
          id
        }) as ReleaseTrackDto
    );
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_BULK_REQUEST_RELEASE:Are you sure you want to release the selected Artists?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_RELEASE:Confirm release`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => this.bulkReleaseTrack(releaseTrackDtos)
    });
  }

  handleReleaseTrack({ id }: Track): void {
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_RELEASE:Are you sure you want to release the selected Track?`,
      header: $localize`:@@DIALOG_LABEL_CONFIRM_RELEASE:Confirm release`,
      icon: 'pi pi-exclamation-triangle',
      accept: () => id && this.releaseTrack({ id })
    });
  }

  handleTagFilter(event: MultiSelectFilterEvent) {
    const tags = this.currentTrack.tags;
    const tagName = event.filter;
    this.currentTrack.tagFilterKeyword = tagName;
    if (tagName?.trim()) {
      this.currentTrack.tagFilterFoundExactMatch = tags.some(({ name }) => name === tagName);
    } else {
      this.currentTrack.tagFilterFoundExactMatch = true;
    }
  }

  handleArtistFilter(event: MultiSelectFilterEvent): void {
    const keyword = (event.filter as string) || '';
    if (!keyword.trim()) {
      this.filteredTrackArtists.length = 0;
      this.filteredTrackArtists.push(...this.trackArtists.slice(0, 50));
      this.filteredTrackArtists.push(...this.currentTrack.trackArtists);
    }
    this.isArtistsLoading.set(true);
    const filteredTrackArtists = this.trackArtists
      .filter(
        ({ artistName }) =>
          this.filterService.filters['startsWith'](artistName, keyword) ||
          this.filterService.filters['contains'](artistName, keyword)
      )
      .slice(0, 50);
    filteredTrackArtists.push(...this.currentTrack.trackArtists);

    this.filteredTrackArtists.length = 0;
    this.filteredTrackArtists.push(...filteredTrackArtists);
    this.isArtistsLoading.set(false);
  }

  handleCreateTag(): void {
    if (this.currentTrack.tagFilterKeyword?.trim()) {
      const tagName: string = this.currentTrack.tagFilterKeyword;
      const tags = this.currentTrack.tags;
      if (!tags.some(({ name }) => name === tagName)) {
        this.currentTrack.tags.push({ name: tagName, isActive: false });
        this.currentTrack.tagFilterKeyword = '';
        this.currentTrack.tagFilterFoundExactMatch = true;
      }
    }
  }

  private deleteTrack(deleteTrackDto: DeleteTrackDto) {
    this.trackService.bulkDeleteTrack({ items: [deleteTrackDto] }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.tracks.update((tracks) => tracks.filter(({ id }) => id !== deleteTrackDto.id));
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_TRACK_DETELED_SUCCESSFUL:Artist was deleted successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private bulkDeleteTrack(deleteTrackDtos: DeleteTrackDto[]) {
    this.trackService.bulkDeleteTrack({ items: deleteTrackDtos }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        const deletedTrackIds = deleteTrackDtos.map(({ id }) => id);
        this.tracks.update((tracks) => tracks.filter(({ id }) => id && !deletedTrackIds.includes(id)));
        this.tracks.update((tracks) =>
          tracks.filter(({ id }) => !deleteTrackDtos.some((deleteTrackDto) => deleteTrackDto.id === id))
        );
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_TRACK_BULK_REQUEST_DETELE_SUCCESSFUL:Bulk delete artist was processed successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private openTrackDialog(action: ActionType): void {
    if (this.action == action) {
      this.isDialogShowed = true;
    } else {
      this.action = action;
      this.isDialogFormSubmitted = false;
      this.isDialogShowed = true;
    }
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
    // Name
    this.nameFormControl.valueChanges.subscribe(
      (value: string) => !this.nameFormControl.errors && (this.currentTrack.name = value)
    );

    // Description
    this.descriptionFormControl.valueChanges.subscribe(
      (value: string) => !this.descriptionFormControl.errors && (this.currentTrack.description = value)
    );

    // Public
    this.isPublicFormControl.valueChanges.subscribe(
      (value: boolean) => !this.isPublicFormControl.errors && (this.currentTrack.isPublic = value)
    );

    // RefCode
    this.refCodeFormControl.valueChanges.subscribe(
      (value: string | null) => !this.refCodeFormControl.errors && (this.currentTrack.refCode = value)
    );

    // ThumbnailUrl
    this.thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) =>
        !this.thumbnailUrlFormControl.errors &&
        ((this.currentTrack.thumbnailUrl = value), this.processImagePreview(value))
    );

    // Tags
    this.tagsFormControl.valueChanges.subscribe(
      (values: string[]) =>
        !this.tagsFormControl.errors &&
        (this.currentTrack.tags = this.currentTrack.tags.map((tag) => ({
          ...tag,
          isActive: values.includes(tag.name)
        })))
    );

    // Official eleased date format
    this.officialReleasedDateFormatFormControl.valueChanges.subscribe(
      (value: DateFormat) => !this.officialReleasedDateFormControl.errors && (this.officialReleasedDateFormat = value)
    );

    // Official eleased date
    this.officialReleasedDateFormControl.valueChanges.subscribe(
      (value: Date) =>
        !this.officialReleasedDateFormControl.errors &&
        (this.currentTrack.officialReleasedDate = formatDate(value, this.officialReleasedDateFormat.format, 'en-US'))
    );

    // Track artists
    this.trackArtistsFormControl.valueChanges.subscribe(
      (values: TrackArtist[]) => !this.trackArtistsFormControl.errors && (this.currentTrack.trackArtists = values)
    );
  }

  private listenAndProcessTrackEvents() {
    this.trackService.changedTracksEvent.subscribe((trackDtos) => {
      const updatedTracksMap: Map<string, Track> = new Map(
        trackDtos.map((trackDto) => [trackDto.id, this.mapToTrack(trackDto)])
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

  private createTrack(createTrackDto: CreateTrackDto): void {
    this.trackService.bulkCreateTrack({ items: [createTrackDto] }).subscribe((respDto) => {
      const { isSuccessful, errors }: CommandResult = respDto.data.items[0];
      if (isSuccessful) {
        this.isDialogFormSubmitted = true;
        this.isDialogShowed = false;
        this.addMessage({
          title: $localize`:@@MESSAGE_CREATE_TRACK_SUCCESS_TITLE:Successful`,
          content: $localize`:@@MESSAGE_CREATE_TRACK_SUCCESS_CONTENT:Track was created successfully.`
        });
      } else {
        const message = this.exceptionHandler.handle(errors[0]);
        this.addMessage(message, 'error');
      }
    });
  }

  private updateTrack(updateTrackDto: UpdateTrackDto): void {
    this.trackService.bulkUpdateTrack({ items: [updateTrackDto] }).subscribe((respDto) => {
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

  private bulkReleaseTrack(releaseTrackDtos: ReleaseTrackDto[]) {
    this.trackService.bulkReleaseTrack({ items: releaseTrackDtos }).subscribe((respDto) => {
      const { isSuccessful, errors } = respDto.data.items[0];
      if (isSuccessful) {
        this.addMessage({
          title: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
          content: $localize`:@@MESSAGE_TRACK_BULK_REQUEST_RELEASE_SUCCESSFUL:Bulk release Track request was processed successfully.`
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
      }))
    };
  }
}
