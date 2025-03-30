import { CreateArtistDto } from './../../../dto/artist-dto';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators, FormArray } from '@angular/forms';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
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
import { TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { ToastModule } from 'primeng/toast';
import { ToggleSwitchModule } from 'primeng/toggleswitch';
import { ToolbarModule } from 'primeng/toolbar';
import { catchError, finalize, take, tap } from 'rxjs';
import { ArtistNationality, UNDEFINED } from '../../../constant/constant';
import { ArtistDto, DeleteArtistDto, UpdateArtistDto } from '../../../dto/artist-dto';
import { ResponseDto } from '../../../dto/response-dto';
import { ExceptionHandler, Message } from '../../../exception/exception-handler';
import { ArtistMapper } from '../../../mapper/artist-mapper';
import { Artist } from '../../../model/artist';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ArtistService } from '../../../service/artist.service';
import { UrlValidator } from '../../../validator/url.validator';
import { MultiSelectModule, MultiSelectFilterEvent } from 'primeng/multiselect';
import { Tag } from '../../../model/tag';
import { CommandResult } from '../../../model/command-result';

interface Column {
  field: string;
  header: string;
  customExportHeader?: string;
}

@Component({
  selector: 'app-artist-management-bulk',
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
    IS_RELEASED_FALSE: $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_RELEASED_NO:No`,
    SAVE: $localize`:@@BUTTON_LABEL_SAVE:Save`,
    UPLOAD_CSV: $localize`:@@BUTTON_LABEL_UPLOAD_CSV:Upload CSV`,
    DELETE: $localize`:@@BUTTON_LABEL_DELETE:Delete`,
    MANAGE_ARTISTS: $localize`:@@PAGE_LABEL_MANAGE_ARTIST:Manage Artists`,
    EDIT_THUMBNAIL: $localize`:@@DIALOG_LABEL_EDIT_THUMBNAIL:Edit Thumbnail`,
    EDIT_BACKGROUND: $localize`:@@DIALOG_LABEL_EDIT_BACKGROUND:Edit Background`,
    EDIT_BIOGRAPHY: $localize`:@@DIALOG_LABEL_EDIT_BIOGRAPHY:Edit Biography`,
    THUMBNAIL_URL: $localize`:@@FORM_LABEL_ARTIST_THUMBNAIL_URL:Thumbnail URL`,
    BACKGROUND_URL: $localize`:@@FORM_LABEL_ARTIST_BACKGROUND_URL:Background URL`,
    CANCEL: $localize`:@@BUTTON_LABEL_CANCEL:Cancel`,
    SUCCESS_THUMBNAIL: $localize`:@@MESSAGE_SUCCESS_THUMBNAIL:Thumbnail URL updated successfully!`,
    SUCCESS_BACKGROUND: $localize`:@@MESSAGE_SUCCESS_BACKGROUND:Background URL updated successfully!`,
    SUCCESS_BIOGRAPHY: $localize`:@@MESSAGE_SUCCESS_BIOGRAPHY:Biography updated successfully!`,
    MESSAGE_CONFIRM_DELETE: $localize`:@@CONFIRM_MESSAGE_ARTIST_DELETE_MULTIPLE:Are you sure you want to delete the selected Artists?`,
    MESSAGE_CONFIRM_DELETE_SINGLE: $localize`:@@CONFIRM_MESSAGE_ARTIST_DELETE_SINGLE:Are you sure you want to delete the Artist?`,
    MESSAGE_DELETED_MULTIPLE_SUCCESSFUL: $localize`:@@MESSAGE_ARTIST_DELETED_MULTIPLE_SUCCESSFUL:Artists were deleted successfully.`,
    MESSAGE_DELETED_SINGLE_SUCCESSFUL: $localize`:@@MESSAGE_ARTIST_DELETED_SINGLE_SUCCESSFUL:Artist was deleted successfully.`,
    DIALOG_SUMMARY_CONFIRM: $localize`:@@DIALOG_SUMMARY_CONFIRM:Confirmed`,
    ARTISTS_UPDATED_SUCCESSFULLY: $localize`:@@MESSAGE_ARTIST_UPDATE_MULTIPLE_SUCCESSFUL:Artists were updated successfully.`,
    FIX_VALIDATION_ERRORS: $localize`:@@FIX_VALIDATION_ERRORS:Please fix the validation errors before saving.`,
    TITLE_SUCCESS: $localize`:@@TITLE_SUCCESS:Success`,
    TITLE_ERROR: $localize`:@@TITLE_ERROR:Error`,
    UPDATE_ARTISTS: $localize`:@@TABLE_LABEL_UPDATE_ARTISTS:Update Artists`,
    SUCCESS_TAGS: $localize`:@@MESSAGE_SUCCESS_TAGS:Tags updated successfully!`,
    NO_RESULTS_FOUND: $localize`:@@MESSAGE_NO_RESULT_FOUND:No results found.`,
    ADD_TAG: $localize`:@@BUTTON_LABEL_ADD_TAG:Add Tag`,
    EDIT_TAGS: $localize`:@@FORM_LABEL_ARTIST_TAG_EDIT:Edit Tags`,
    TAGS: $localize`:@@COLUMN_LABEL_MANAGE_ARTIST_TAG:Tags`,
    EXPORT_TEMPLATE: $localize`:@@BUTTON_LABEL_EXPORT_TEMPLATE:Export Template`,
    IMPORT_SUCCESSFUL: $localize`:@@MESSAGE_IMPORT_SUCCESSFUL:CSV data has been imported successfully`,
    CREATE_ARTISTS: $localize`:@@TABLE_LABEL_CREATE_ARTISTS:Create Artists`,
    DELETE_FROM_LIST: $localize`:@@BUTTON_LABEL_DELETE_FROM_LIST:Delete from List`,
  };

  // Constants
  readonly UNDEFINED = UNDEFINED;
  readonly artistNationalities: { code: string; name: string }[] = Object.keys(ArtistNationality).map((key) => ({
    code: key,
    name: `${ArtistNationality[key as keyof typeof ArtistNationality]}`
  }));

  // State
  readonly renderableImageUrls: string[] = [];
  readonly selectedArtists: Artist[] = [];
  readonly artists: WritableSignal<Artist[]> = signal<Artist[]>([]);
  readonly columns: Column[] = [];
  readonly loading = signal(false);

  selectedArtistIndex: number = -1;
  ids: string | null = null;
  isEdit: boolean = false;

  // Tag management
  tagFilterKeyword: string | null = null;
  tagFilterFoundExactMatch: boolean = true;

  // Single FormArray for all artists
  artistsForm: FormArray<FormGroup>;

  // Dialog states
  isImageDialogVisible = false;
  isBackgroundDialogVisible = false;
  isBiographyDialogVisible = false;
  isTagsDialogVisible = false;

  readonly headers: string[] = [
    'name',
    'isVerified',
    'isPublic',
    'description',
    'biography',
    'nationalityIsoCode',
    'thumbnailUrl',
    'backgroundUrl',
    'refCode',
    'tagsJson'
  ];

  constructor(
    private readonly route: ActivatedRoute,
    private readonly messageService: MessageService,
    private readonly confirmationService: ConfirmationService,
    private readonly artistService: ArtistService,
    private readonly http: HttpClient,
    private readonly artistMapper: ArtistMapper,
    private readonly exceptionHandler: ExceptionHandler,
    private readonly router: Router,
    public readonly fb: FormBuilder
  ) {
    // Forms
    this.artistsForm = this.fb.array<FormGroup>([]);
  }

  ngOnInit(): void {
    this.initializeComponent();
  }

  // Public methods for template
  handleGetFormGroupAt(index: number): FormGroup {
    return this.artistsForm.at(index) as FormGroup;
  }

  handleGetSelectedArtistFormGroup(): FormGroup | null {
    if (this.selectedArtistIndex === -1) return null;
    return this.handleGetFormGroupAt(this.selectedArtistIndex);
  }

  handleGetSelectedArtist(): Artist | null {
    if (this.selectedArtistIndex === -1) return null;
    return this.artists()[this.selectedArtistIndex];
  }

  handleOpenTagsDialog(artist: Artist): void {
    const index = this.findArtistIndex(artist.id);
    if (index === -1) return;

    this.selectedArtistIndex = index;
    this.tagFilterKeyword = null;
    this.tagFilterFoundExactMatch = true;

    // Reset form controls for tags
    if (!this.handleGetFormGroupAt(this.selectedArtistIndex).get('tags')) {
      this.handleGetFormGroupAt(this.selectedArtistIndex).addControl(
        'tags',
        this.fb.control(artist.tags.filter((tag) => tag.isActive).map((tag) => tag.name))
      );
    } else {
      this.handleGetFormGroupAt(this.selectedArtistIndex)
        .get('tags')
        ?.setValue(artist.tags.filter((tag) => tag.isActive).map((tag) => tag.name));
    }

    this.isTagsDialogVisible = true;
  }

  handleSaveTags(): void {
    if (this.selectedArtistIndex === -1) return;

    const formGroup = this.handleGetFormGroupAt(this.selectedArtistIndex);
    const activeTags = formGroup.get('tags')?.value || [];

    // Update the artist model to keep in sync
    const artist = this.artists()[this.selectedArtistIndex];

    // Update isActive status for all tags
    artist.tags = artist.tags.map((tag) => ({
      ...tag,
      isActive: activeTags.includes(tag.name)
    }));

    this.isTagsDialogVisible = false;
    this.showSuccessMessage(this.I18N.TITLE_SUCCESS, this.I18N.SUCCESS_TAGS);
  }

  handleTagFilter(event: MultiSelectFilterEvent): void {
    const tagName = event.filter;
    this.tagFilterKeyword = tagName;

    if (tagName?.trim()) {
      const artist = this.handleGetSelectedArtist();
      this.tagFilterFoundExactMatch = !!(artist && artist.tags.some(({ name }) => name === tagName));
    } else {
      this.tagFilterFoundExactMatch = true;
    }
  }

  handleCreateTag(): void {
    if (!this.tagFilterKeyword?.trim() || this.selectedArtistIndex === -1) return;

    const tagName = this.tagFilterKeyword;
    const artist = this.artists()[this.selectedArtistIndex];

    if (!artist.tags.some(({ name }) => name === tagName)) {
      // Add new tag to artist's tags
      artist.tags.push({ name: tagName, isActive: true });

      // Update form control value
      const formGroup = this.handleGetFormGroupAt(this.selectedArtistIndex);
      const currentTags = formGroup.get('tags')?.value || [];
      formGroup.get('tags')?.setValue([...currentTags, tagName]);

      // Reset filter state
      this.tagFilterKeyword = null;
      this.tagFilterFoundExactMatch = true;
    }
  }

  handleDeleteSelectedArtists(event: Event): void {
    this.confirmationService.confirm({
      target: event.target as EventTarget,
      message: this.I18N.MESSAGE_CONFIRM_DELETE,
      icon: 'pi pi-info-circle',
      rejectButtonProps: {
        label: this.I18N.CANCEL,
        severity: 'secondary',
        outlined: true
      },
      acceptButtonProps: {
        label: this.I18N.DELETE,
        severity: 'danger'
      },
      accept: () => {
        this.deleteSelectedArtists();
      }
    });
  }

  handleSaveArtists(): void {
    if (!this.isEdit) {
      // Create new artists
      const createArtistsDto: CreateArtistDto[] = [];
      this.artistsForm.controls.forEach((formGroup) => {
        const createArtistDto: CreateArtistDto = {
          profile: {
            name: formGroup.get('name')?.value,
            description: formGroup.get('description')?.value,
            biography: formGroup.get('biography')?.value || null,
            nationalityIsoCode: formGroup.get('nationalityIsoCode')?.value || null,
            thumbnailUrl: formGroup.get('thumbnailUrl')?.value || null,
            backgroundUrl: formGroup.get('backgroundUrl')?.value || null
          },
          refCode: formGroup.get('refCode')?.value || null,
          isPublic: formGroup.get('isPublic')?.value || false,
          tags: formGroup.get('tags')?.value.map((tag: string) => ({ name: tag, isActive: true })) || []
        };
        createArtistsDto.push(createArtistDto);
      });
      if (createArtistsDto.length > 0) {
        this.createArtist(createArtistsDto);
      }
    } else {
      // Update existing artists
      this.updateArtists();
    }
  }

  handleDeleteArtist(event: Event, artist: Artist): void {
    this.confirmationService.confirm({
      target: event.target as EventTarget,
      message: this.I18N.MESSAGE_CONFIRM_DELETE_SINGLE,
      icon: 'pi pi-info-circle',
      rejectButtonProps: {
        label: this.I18N.CANCEL,
        severity: 'secondary',
        outlined: true
      },
      acceptButtonProps: {
        label: this.I18N.DELETE,
        severity: 'danger'
      },
      accept: () => {
        const index = this.findArtistIndex(artist.id);
        if (index !== -1) {
          this.deleteArtist({ id: artist.id }, index);
          this.showSuccessMessage(this.I18N.DIALOG_SUMMARY_CONFIRM, this.I18N.MESSAGE_DELETED_SINGLE_SUCCESSFUL);
        }
      }
    });
  }

  handleOpenThumbnailDialog(artist: Artist): void {
    const index = this.findArtistIndex(artist.id);
    if (index === -1) return;

    this.selectedArtistIndex = index;

    // Ensure URL is processed for preview
    const thumbnailUrl = artist.profile.thumbnailUrl;
    if (thumbnailUrl) {
      this.processImagePreview(thumbnailUrl);
    }

    this.isImageDialogVisible = true;
  }

  handleSaveThumbnailUrl(): void {
    if (this.selectedArtistIndex === -1) return;

    const formGroup = this.handleGetFormGroupAt(this.selectedArtistIndex);
    const thumbnailUrl = formGroup.get('thumbnailUrl')?.value;

    // Update the artist model to keep in sync
    const artist = this.artists()[this.selectedArtistIndex];
    artist.profile.thumbnailUrl = thumbnailUrl;

    this.isImageDialogVisible = false;
    this.showSuccessMessage(this.I18N.TITLE_SUCCESS, this.I18N.SUCCESS_THUMBNAIL);
  }

  handleOpenBackgroundDialog(artist: Artist): void {
    const index = this.findArtistIndex(artist.id);
    if (index === -1) return;

    this.selectedArtistIndex = index;

    // Ensure URL is processed for preview
    const backgroundUrl = artist.profile.backgroundUrl;
    if (backgroundUrl) {
      this.processImagePreview(backgroundUrl);
    }

    this.isBackgroundDialogVisible = true;
  }

  handleSaveBackgroundUrl(): void {
    if (this.selectedArtistIndex === -1) return;

    const formGroup = this.handleGetFormGroupAt(this.selectedArtistIndex);
    const backgroundUrl = formGroup.get('backgroundUrl')?.value;

    // Update the artist model to keep in sync
    const artist = this.artists()[this.selectedArtistIndex];
    artist.profile.backgroundUrl = backgroundUrl;

    this.isBackgroundDialogVisible = false;
    this.showSuccessMessage(this.I18N.TITLE_SUCCESS, this.I18N.SUCCESS_BACKGROUND);
  }

  handleOpenBiographyDialog(artist: Artist): void {
    const index = this.findArtistIndex(artist.id);
    if (index === -1) return;

    this.selectedArtistIndex = index;
    this.isBiographyDialogVisible = true;

    // Use setTimeout to ensure the editor is initialized before setting value
    setTimeout(() => {
      const formGroup = this.handleGetFormGroupAt(this.selectedArtistIndex);
      // Make sure the biography form control has proper value
      if (formGroup.get('biography')) {
        // Force a re-render by setting value to empty first
        formGroup.get('biography')?.setValue('');
        formGroup.get('biography')?.setValue(artist.profile.biography || '');
      }
    }, 50);
  }

  handleSaveBiography(): void {
    if (this.selectedArtistIndex === -1) return;

    const formGroup = this.handleGetFormGroupAt(this.selectedArtistIndex);
    const biography = formGroup.get('biography')?.value;

    // Update the artist model to keep in sync
    const artist = this.artists()[this.selectedArtistIndex];
    artist.profile.biography = biography;

    this.isBiographyDialogVisible = false;
    this.showSuccessMessage(this.I18N.TITLE_SUCCESS, this.I18N.SUCCESS_BIOGRAPHY);
  }

  handleImportCSV(event: Event): void {
    const fileInput = event.target as HTMLInputElement;
    const file = fileInput.files?.[0];

    if (!file) return;

    const reader = new FileReader();

    reader.onload = (e) => {
      const csvContent = e.target?.result as string;
      this.parseCSV(csvContent);
    };

    reader.readAsText(file);
  }

  handleExportCSVTemplate(): void {
    const headers = [
      'name',
      'isverified',
      'ispublic',
      'description',
      'biography',
      'nationalityisocode',
      'thumbnailurl',
      'backgroundurl',
      'refcode',
      'tagsjson'
    ];

    let csv = headers.join(',') + '\n';

    // Add sample row if there's no data
    if (this.artists().length === 0) {
      csv +=
        'Artist Name,TRUE,TRUE,Description text,Biography content,US,' +
        'https://example.com/image.jpg,https://example.com/background.jpg,' +
        'REF123,"[""Ngô Thiên""]"\n';
    } else {
      // Add actual data
      this.artists().forEach((artist) => {
        const tagJson = JSON.stringify(artist.tags.filter((t) => t.isActive).map((t) => t.name));

        const row = [
          this.escapeCsvValue(artist.profile.name || ''),
          artist.isVerified,
          artist.isPublic,
          this.escapeCsvValue(artist.profile.description || ''),
          this.escapeCsvValue(artist.profile.biography || ''),
          artist.profile.nationalityIsoCode,
          this.escapeCsvValue(artist.profile.thumbnailUrl || ''),
          this.escapeCsvValue(artist.profile.backgroundUrl || ''),
          this.escapeCsvValue(artist.refCode || ''),
          this.escapeCsvValue(tagJson)
        ];

        csv += row.join(',') + '\n';
      });
    }

    this.downloadCSV(csv, 'artist_template.csv');
  }

  // Private methods
  private initializeComponent(): void {
    this.setupFormListeners();
    this.loadArtistData();
  }

  private loadArtistData(): void {
    this.route.queryParamMap
      .pipe(
        take(1),
        tap((params) => {
          this.ids = params.get('ids');
        })
      )
      .subscribe(() => {
        if (this.ids) {
          this.isEdit = true;
          this.fetchArtists(this.ids);
        }
      });
  }

  private fetchArtists(idString: string): void {
    const artistIds = idString.split(',').map((id) => id.trim());

    this.loading.set(true);
    this.artistService
      .getArtistByIds(artistIds, true, true)
      .pipe(
        tap((response: ResponseDto<[ArtistDto | null]>) => {
          const filteredArtists = response.data
            .filter((artistDto): artistDto is ArtistDto => artistDto !== null)
            .map((artistDto) => this.artistMapper.mapToArtist(artistDto));

          this.artists.set(filteredArtists);
          this.rebuildFormArray(filteredArtists);
        }),
        catchError((error) => {
          this.exceptionHandler.handle(error);
          return [];
        }),
        finalize(() => {
          this.loading.set(false);
        })
      )
      .subscribe();
  }

  private rebuildFormArray(artists: Artist[]): void {
    this.artistsForm.clear();
    artists.forEach((artist) => {
      this.artistsForm.push(this.createArtistFormGroup(artist));
    });
  }

  private createArtistFormGroup(artist: Artist): FormGroup {
    return this.fb.group({
      id: [artist.id],
      name: [artist.profile.name, Validators.required],
      nationalityIsoCode: [artist.profile.nationalityIsoCode],
      isPublic: [artist.isPublic],
      isVerified: [artist.isVerified],
      isReleased: [artist.isReleased],
      revisionNumber: [artist.revisionNumber],
      refCode: [artist.refCode],
      description: [artist.profile.description],
      biography: [artist.profile.biography || ''],
      thumbnailUrl: [artist.profile.thumbnailUrl || ''],
      backgroundUrl: [artist.profile.backgroundUrl || ''],
      tags: [artist.tags.filter((tag) => tag.isActive).map((tag) => tag.name)]
    });
  }

  private setupFormListeners(): void {
    // Monitor URL changes in all form groups to update the renderableImageUrls
    this.artistsForm.valueChanges.subscribe((formValues) => {
      if (!formValues) return;

      formValues.forEach((formValue) => {
        if (formValue.thumbnailUrl) {
          this.processImagePreview(formValue.thumbnailUrl);
        }
        if (formValue.backgroundUrl) {
          this.processImagePreview(formValue.backgroundUrl);
        }
      });
    });
  }

  private createArtist(createArtistDto: CreateArtistDto[]): void {
    this.artistService.bulkCreateArtist({ items: createArtistDto }).subscribe((respDto) => {
      const { isSuccessful, errors }: CommandResult = respDto.data.items[0];
      if (isSuccessful) {
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

  private escapeCsvValue(value: string): string {
    if (!value) return '';

    // If the value contains commas, quotes, or newlines, wrap in quotes and escape existing quotes
    if (value.includes(',') || value.includes('"') || value.includes('\n')) {
      return `"${value.replace(/"/g, '""')}"`;
    }
    return value;
  }

  private downloadCSV(csv: string, filename: string): void {
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);

    link.setAttribute('href', url);
    link.setAttribute('download', filename);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  private createArtistFromCSV(data: any): Artist {
    // Generate a temporary ID for new artists
    const tempId = 'temp_' + Date.now() + '_' + Math.floor(Math.random() * 1000);

    // Parse tags from JSON string if available
    let tags: Tag[] = [];
    if (data.tagsJson) {
      try {
        // Parse the JSON string into an array of tag names
        const tagNames = data.tagsJson;
        tags = Array.isArray(tagNames) ? tagNames.map((name) => ({ name, isActive: true })) : [];
      } catch (e) {
        console.error('Error parsing tagsJson:', data.tagsJson, e);
      }
    }

    return {
      id: tempId,
      urn: data.urn || '',
      profile: {
        name: data.name || '',
        nationalityIsoCode: data.nationalityIsoCode || '',
        description: data.description || '',
        biography: data.biography || '',
        thumbnailUrl: data.thumbnailUrl || '',
        backgroundUrl: data.backgroundUrl || ''
      },
      refCode: data.refCode || '',
      isPublic: data.isPublic === 'TRUE',
      isVerified: data.isVerified === 'TRUE',
      isReleased: false,
      revisionNumber: 0,
      tags: tags,
      createdAt: data.createdAt || new Date().toISOString(),
      updatedAt: data.updatedAt || new Date().toISOString(),
      createdBy: data.createdBy || null,
      updatedBy: data.updatedBy || null
    };
  }

  private parseCSV(csvContent: string): void {
    const lines = csvContent.split('\n');

    // Reset current artists
    this.artists.set([]);
    this.artistsForm.clear();

    // Process each line
    for (let i = 1; i < lines.length; i++) {
      if (!lines[i].trim()) continue; // Skip empty lines

      const values = this.splitCSVLine(lines[i]);
      const artistData: any = {};

      // Map CSV columns to artist properties
      this.headers.forEach((header, index) => {
        artistData[header] = values[index]?.trim();
        if (header === 'tagsJson' && artistData[header]) {
          try {
            // Parse JSON string, handling escaped double quotes
            artistData[header] = JSON.parse(artistData[header].replace(/""/g, '"'));
          } catch (e) {
            console.error('Error parsing tagsJson:', artistData[header], e);
            artistData[header] = [];
          }
        }
      });

      // Create artist object
      const artist = this.createArtistFromCSV(artistData);

      // Add to state
      this.artists.update((artists) => [...artists, artist]);
      this.artistsForm.push(this.createArtistFormGroup(artist));
    }

    // Show success message
    this.showSuccessMessage(this.I18N.TITLE_SUCCESS, this.I18N.IMPORT_SUCCESSFUL);
  }

  private splitCSVLine(line: string): string[] {
    const result = [];
    let current = '';
    let inQuotes = false;

    for (let i = 0; i < line.length; i++) {
      const char = line[i];

      if (char === '"' && (i === 0 || line[i - 1] !== '\\')) {
        if (inQuotes && line[i + 1] === '"') {
          // Handle escaped double quotes
          current += '"';
          i++; // Skip the next quote
        } else {
          inQuotes = !inQuotes;
        }
      } else if (char === ',' && !inQuotes) {
        result.push(current.trim());
        current = '';
      } else {
        current += char;
      }
    }

    result.push(current.trim()); // Add the last value
    return result;
  }

  private updateArtists(): void {
    if (!this.artistsForm.valid) {
      this.showErrorMessage(this.I18N.TITLE_ERROR, this.I18N.FIX_VALIDATION_ERRORS);
      return;
    }

    const updatedArtists = this.syncFormToArtistModels();

    const updateArtistDtos = updatedArtists.map((artist) => ({
      id: artist.id,
      profile: {
        name: artist.profile.name,
        nationalityIsoCode: artist.profile.nationalityIsoCode,
        description: artist.profile.description,
        biography: artist.profile.biography,
        thumbnailUrl: artist.profile.thumbnailUrl,
        backgroundUrl: artist.profile.backgroundUrl
      },
      refCode: artist.refCode,
      isPublic: artist.isPublic,
      isVerified: artist.isVerified,
      isReleased: artist.isReleased,
      tags: artist.tags
    }));

    this.updateArtist(updateArtistDtos);
  }

  private updateArtist(updateArtistDto: UpdateArtistDto[]): void {
    this.artistService.bulkUpdateArtist({ items: updateArtistDto }).subscribe({
      next: (response) => {
        const isSuccessful = response.data.items.every((item) => item.isSuccessful);
        if (isSuccessful) {
          this.showSuccessMessage(this.I18N.TITLE_SUCCESS, this.I18N.ARTISTS_UPDATED_SUCCESSFULLY);
        } else {
          const errors = response.data.items.filter((item) => !item.isSuccessful).map((item) => item.errors[0]);
          const errorMessage = this.exceptionHandler.handle(errors[0]);
          this.showErrorMessage(this.I18N.TITLE_ERROR, errorMessage.content);
        }
      },
      error: (error) => {
        const errorMessage = this.exceptionHandler.handle(error);
        this.showErrorMessage(this.I18N.TITLE_ERROR, errorMessage.content);
      }
    });
  }

  private syncFormToArtistModels(): Artist[] {
    return this.artistsForm.controls.map((formGroup, index) => {
      const artist = this.artists()[index];
      const formValue = formGroup.value;

      artist.profile.name = formValue.name;
      artist.profile.nationalityIsoCode = formValue.nationalityIsoCode;
      artist.isPublic = formValue.isPublic;
      artist.isVerified = formValue.isVerified;
      artist.isReleased = formValue.isReleased;
      artist.refCode = formValue.refCode;
      artist.profile.description = formValue.description;
      artist.profile.biography = formValue.biography;
      artist.profile.thumbnailUrl = formValue.thumbnailUrl;
      artist.profile.backgroundUrl = formValue.backgroundUrl;

      return artist;
    });
  }

  private deleteSelectedArtists(): void {
    this.selectedArtists.forEach((artist) => {
      const index = this.findArtistIndex(artist.id);
      if (index !== -1) {
        this.deleteArtist({ id: artist.id }, index);
      }
    });

    this.showSuccessMessage(this.I18N.DIALOG_SUMMARY_CONFIRM, this.I18N.MESSAGE_DELETED_MULTIPLE_SUCCESSFUL);
  }

  private deleteArtist(deleteArtistDto: DeleteArtistDto, index: number): void {
    const { id } = deleteArtistDto;
    this.artists.update((artists) => artists.filter((artist) => artist.id !== id));
    this.artistsForm.removeAt(index);
  }

  private findArtistIndex(id: string): number {
    return this.artists().findIndex((artist) => artist.id === id);
  }

  private processImagePreview(url: string): void {
    if (!url || this.renderableImageUrls.includes(url)) return;

    this.http.head(url, { observe: 'response' }).subscribe({
      next: (resp) => {
        if (resp.status === 200 && resp.headers.get('Content-Type')?.startsWith('image')) {
          this.renderableImageUrls.push(url);
        }
      },
      error: () => {
        // Silently fail - image might not be accessible
      }
    });
  }

  private showSuccessMessage(title: string, content: string): void {
    this.addMessage({ title, content }, 'success');
  }

  private showErrorMessage(title: string, content: string): void {
    this.addMessage({ title, content }, 'error');
  }

  private addMessage({ title, content }: Message, severity: string = 'success', key?: string): void {
    this.messageService.add({
      severity,
      summary: title,
      detail: content,
      life: 3000,
      key
    });
  }
}
