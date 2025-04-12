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
import { TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { ToastModule } from 'primeng/toast';
import { ToolbarModule } from 'primeng/toolbar';
import { URL_REGEX } from '../../../constant/constant';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { Tag } from '../../../model/tag';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { TrackService } from '../../../service/track.service';
import { TrackDto } from './../../../dto/track-dto';

type ActionType = 'new' | 'edit';

interface Column {
  field: string;
  header: string;
  exportHeader: string | null;
}

interface Artist {
  id: string;
  name: string;
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
    // SafeHtmlPipe,
    IconFieldModule,
    InputIconModule,
    RouterModule,
    CheckboxModule,
    PopoverModule,
    MultiSelectModule,
    InputGroupModule,
    InputGroupAddonModule
  ],
  templateUrl: './track-management.component.html',
  styleUrl: './track-management.component.scss',
  providers: [MessageService, ConfirmationService, TrackService]
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
  readonly nameFormControl: FormControl = new FormControl<string>('', [Validators.required, Validators.maxLength(250)]);
  readonly descriptionFormControl: FormControl = new FormControl<string>('');
  readonly thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly isPublicFormControl: FormControl = new FormControl<boolean>(false);
  readonly tagsFormControl: FormControl = new FormControl<Tag[]>([]);
  readonly officialReleasedDateFormControl: FormControl = new FormControl<Date>(new Date());
  readonly refCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly trackFormGroup: FormGroup = new FormGroup({
    nameFormControl: this.nameFormControl,
    descriptionFormControl: this.descriptionFormControl,
    thumbnailUrlFormControl: this.thumbnailUrlFormControl,
    tagsFormControl: this.tagsFormControl,
    refCodeFormControl: this.refCodeFormControl,
    isPublicFormControl: this.isPublicFormControl,
    officialReleasedDateFormControl: this.officialReleasedDateFormControl
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
    private readonly http: HttpClient,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    this.loadData();
    this.listenAndProcessFormControlValueChange();
  }

  handleNewTrack(): void {
    this.currentTrack = this.emptyTrack();
    this.refCodeFormControl.enable();
    if (this.action === 'edit' || this.isDialogFormSubmitted) {
      // These two cases: [The action is edit before, the Artist (create, edit) was saved]
      // We'll erase the data in the form.
      this.trackFormGroup.reset();
    }
    this.openArtistDialog('new');
  }

  handleEditTrack(track: Track): void {
    this.currentTrack = track;
    const { name, description, thumbnailUrl, refCode, isPublic, tags } = this.currentTrack;
    this.nameFormControl.setValue(name);
    this.descriptionFormControl.setValue(description);
    this.thumbnailUrlFormControl.setValue(thumbnailUrl);
    this.refCodeFormControl.setValue(refCode);
    this.isPublicFormControl.setValue(isPublic);
    this.tagsFormControl.setValue(tags.filter(({ isActive }) => isActive).map(({ name }) => name));
    track.revisionNumber > -1 && this.refCodeFormControl.disable();
    this.openArtistDialog('edit');
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

  private loadData(): void {
    this.isLoading.set(true);
    this.trackService.getAllTracks(true, true).subscribe((respDto) => {
      this.tracks.set(respDto.data.map((trackDto) => this.mapToTrack(trackDto)));
      this.isLoading.set(false);
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
      tagFilterFoundExactMatch: true
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
      tagFilterFoundExactMatch: true
    };
  }
}
