import { map } from 'rxjs';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import {
  FormArray,
  FormBuilder,
  FormControl,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators
} from '@angular/forms';
import { ActivatedRoute, Params, Router, RouterModule } from '@angular/router';
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
import { MultiSelectFilterEvent, MultiSelectModule } from 'primeng/multiselect';
import { PanelModule } from 'primeng/panel';
import { RadioButtonModule } from 'primeng/radiobutton';
import { RatingModule } from 'primeng/rating';
import { RippleModule } from 'primeng/ripple';
import { SelectModule } from 'primeng/select';
import { TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { ToastModule } from 'primeng/toast';
import { ToggleSwitchModule } from 'primeng/toggleswitch';
import { ToolbarModule } from 'primeng/toolbar';
import { ARTIST_NATIONALITIES, UNDEFINED, URL_REGEX } from '../../../constant/constant';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { ArtistMapper } from '../../../mapper/artist-mapper';
import { Artist } from '../../../model/artist';
import { Nationality } from '../../../model/nationality';
import { Tag } from '../../../model/tag';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ArtistService } from '../../../service/artist.service';
import { UrlValidator } from '../../../validator/url.validator';
import { ArtistNationalityNamePipe } from './../../../pipe/artist-nationality.pipe';
import { UpdateArtistDto } from './../../../dto/artist-dto';
import { CommandResult } from '../../../model/command-result';
interface Column {
  field: string;
  header: string;
  customExportHeader?: string;
}
type ActionType = 'import' | 'edit';

interface ArtistAttribute {
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
    MultiSelectModule
  ],
  templateUrl: './artist-management-bulk.component.html',
  styleUrl: './artist-management-bulk.component.scss',
  providers: [MessageService, ArtistService, ConfirmationService, UrlValidator]
})
export class ArtistManagementBulkComponent implements OnInit {
  // I18N Constants
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

  // State
  readonly renderableImageUrls: string[] = [];
  readonly selectedArtists: Artist[] = [];
  readonly artistAttributes: WritableSignal<ArtistAttribute[]> = signal<ArtistAttribute[]>([]);
  readonly columns: Column[] = [];
  readonly isLoading = signal(false);
  currentArtistAttribute: ArtistAttribute | null = null;
  action: ActionType = 'import';
  artistForms: FormArray;
  ids: string[] = [];

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly messageService: MessageService,
    private readonly confirmationService: ConfirmationService,
    private readonly artistService: ArtistService,
    private readonly http: HttpClient,
    private readonly artistMapper: ArtistMapper,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly router: Router,
    readonly formBuilder: FormBuilder
  ) {
    this.artistForms = this.formBuilder.array<FormGroup>([]);
  }

  ngOnInit(): void {
    this.listenAndProcessActiveRouteParams();
  }

  handleTagFilter(event: MultiSelectFilterEvent, artistAttribute: ArtistAttribute) {
    const tags = artistAttribute.tags;
    const tagName = event.filter;
    artistAttribute.tagFilterKeyword = tagName;
    if (tagName?.trim()) {
      artistAttribute.tagFilterFoundExactMatch = tags.some(({ name }) => name === tagName);
    } else {
      artistAttribute.tagFilterFoundExactMatch = true;
    }
  }

  handleCreateTag(artistAttribute: ArtistAttribute): void {
    if (artistAttribute.tagFilterKeyword?.trim()) {
      const tagName: string = artistAttribute.tagFilterKeyword;
      const tags = artistAttribute.tags;
      if (!tags.some(({ name }) => name === tagName)) {
        artistAttribute.tags.push({ name: tagName, isActive: false });
        artistAttribute.tagFilterKeyword = '';
        artistAttribute.tagFilterFoundExactMatch = true;
      }
    }
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
      const artists: Artist[] = respDto.data
        .filter((artistDto) => artistDto != null)
        .map(this.artistMapper.mapToArtist);
      const artistAttributes = artists.map(
        ({
          id,
          profile: { name, description, biography, thumbnailUrl, backgroundUrl, nationalityIsoCode },
          isPublic,
          isReleased,
          refCode,
          tags,
          urn,
          revisionNumber,
          isVerified
        }) => {
          const artistAttribute: ArtistAttribute = {
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
          this.createArtistFormGroup(artistAttribute);
          return artistAttribute;
        }
      );
      this.artistAttributes.set(artistAttributes);
    });
  }

  handleRemoveRow(rowIndex: number): void {
    this.artistAttributes.update((artistAttributes) =>
      artistAttributes.filter((artistAttribute, index) => index !== rowIndex)
    );
  }

  private createArtistFormGroup(artistAttribute: ArtistAttribute) {
    const { name, thumbnailUrl, nationalityIsoCode, backgroundUrl, description, biography, tags, refCode, isPublic } =
      artistAttribute;

    // Name
    const nameFormControl: FormControl = new FormControl<string>(name || '', [
      Validators.required,
      Validators.maxLength(250)
    ]);
    nameFormControl.valueChanges.subscribe(
      (value: string) => !nameFormControl.errors && (artistAttribute.name = value)
    );

    // Nationality
    const nationalityIsoCodeFormControl: FormControl = new FormControl<string>(nationalityIsoCode || UNDEFINED);
    nationalityIsoCodeFormControl.valueChanges.subscribe(
      (value: string) => !nationalityIsoCodeFormControl.errors && (artistAttribute.nationalityIsoCode = value)
    );

    // Thumbnail URL
    const thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
    thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) => !thumbnailUrlFormControl.errors && this.processImagePreview(value)
    );
    thumbnailUrlFormControl.setValue(thumbnailUrl);

    // Background URL
    const backgroundUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
    backgroundUrlFormControl.valueChanges.subscribe(
      (value: string) => !backgroundUrlFormControl.errors && this.processImagePreview(value)
    );
    backgroundUrlFormControl.setValue(backgroundUrl);

    // Description URL
    const descriptionFormControl: FormControl = new FormControl<string>(description || '');
    descriptionFormControl.valueChanges.subscribe(
      (value: string) => !descriptionFormControl.errors && (artistAttribute.description = value)
    );

    // Biography URL
    const biographyUrlFormControl: FormControl = new FormControl<string>(biography || '');
    biographyUrlFormControl.valueChanges.subscribe(
      (value: string) => !biographyUrlFormControl.errors && (artistAttribute.biography = value)
    );

    // Reference code
    const refCodeFormControl: FormControl = new FormControl<string>(refCode || '');
    artistAttribute.revisionNumber > -1 && refCodeFormControl.disable();
    refCodeFormControl.valueChanges.subscribe(
      (value: string) => !refCodeFormControl.errors && (artistAttribute.refCode = value)
    );

    // Public
    const isPublicFormControl: FormControl = new FormControl<boolean>(isPublic);
    isPublicFormControl.valueChanges.subscribe(
      (value: boolean) => !isPublicFormControl.errors && (artistAttribute.isPublic = value)
    );

    // Tags
    const tagsFormControl: FormControl = new FormControl<Tag[]>(tags);
    tagsFormControl.valueChanges.subscribe(
      (values: string[]) =>
        !tagsFormControl.errors &&
        (artistAttribute.tags = artistAttribute.tags.map((tag) => ({
          ...tag,
          isActive: values.includes(tag.name)
        })))
    );
    tagsFormControl.setValue(tags.filter(({ isActive }) => isActive).map(({ name }) => name));

    artistAttribute.formGroup = new FormGroup({
      nameFormControl,
      thumbnailUrlFormControl,
      backgroundUrlFormControl,
      nationalityIsoCodeFormControl,
      descriptionFormControl,
      biographyUrlFormControl,
      tagsFormControl,
      refCodeFormControl,
      isPublicFormControl
    });
  }

  handleEditThumbnail(artistAttribute: ArtistAttribute): void {
    artistAttribute.isThumbnailDialogShowed = true;
  }

  handleEditBackground(artistAttribute: ArtistAttribute): void {
    artistAttribute.isBackgroundDialogShowed = true;
  }

  handleEditBiography(artistAttribute: ArtistAttribute): void {
    artistAttribute.isBiographyDialogShowed = true;
  }

  handleThumbnailDialogClose(artistAttribute: ArtistAttribute, isChanged: boolean = false): void {
    const thumbnailUrlFormControl: FormControl | null = artistAttribute.formGroup?.get(
      'thumbnailUrlFormControl'
    ) as FormControl<string>;
    if (thumbnailUrlFormControl) {
      if (isChanged) {
        artistAttribute.thumbnailUrl = !thumbnailUrlFormControl.errors && thumbnailUrlFormControl.value;
      } else {
        thumbnailUrlFormControl.setValue(artistAttribute.thumbnailUrl);
      }
    }
    artistAttribute.isThumbnailDialogShowed = false;
  }

  handleBackgroundDialogClose(artistAttribute: ArtistAttribute, isChanged: boolean = false): void {
    const backgroundUrlFormControl: FormControl | null = artistAttribute.formGroup?.get(
      'backgroundUrlFormControl'
    ) as FormControl<string>;
    if (backgroundUrlFormControl) {
      if (isChanged) {
        artistAttribute.backgroundUrl = !backgroundUrlFormControl.errors && backgroundUrlFormControl.value;
      } else {
        backgroundUrlFormControl.setValue(artistAttribute.backgroundUrl);
      }
    }
    artistAttribute.isThumbnailDialogShowed = false;
  }

  handleBiographyDialogClose(artistAttribute: ArtistAttribute, isChanged: boolean = false): void {
    const biographyFormControl: FormControl | null = artistAttribute.formGroup?.get(
      'biographyFormControl'
    ) as FormControl<string>;
    if (biographyFormControl) {
      if (isChanged) {
        artistAttribute.biography = !biographyFormControl.errors && biographyFormControl.value;
      } else {
        biographyFormControl.setValue(artistAttribute.biography);
      }
    }
    artistAttribute.isBiographyDialogShowed = false;
  }

  handleBulkSaveArtist(): void {
    if (this.action === 'edit') {
      const updateArtistDtos: UpdateArtistDto[] = this.artistAttributes().map(
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
        }: ArtistAttribute) =>
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
      // TODO: Handle import action
    }
  }

  private bulkUpdateArtist(updateArtistDtos: UpdateArtistDto[]): void {
    this.artistService.bulkUpdateArtist({ items: updateArtistDtos }).subscribe((respDto) => {
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

  private emptyArtistAttribute(): ArtistAttribute {
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
      tagFilterKeyword: '',
      tagFilterFoundExactMatch: true,
      formGroup: null,
      isBackgroundDialogShowed: false,
      isThumbnailDialogShowed: false,
      isBiographyDialogShowed: false
    };
  }
}
