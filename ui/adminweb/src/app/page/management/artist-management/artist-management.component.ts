import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, signal, WritableSignal } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ConfirmationService, MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
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
import { ArtistNationality, URL_REGEX } from '../../../constant/constant';
import { ResponseDto } from '../../../dto/response-dto';
import { ArtistNationalityPipe } from '../../../pipe/artist-nationality.pipe';
import { ArtistService } from '../../../service/artist.service';
import { UrlValidator } from '../../../validator/url.validator';
import { ArtistDto, CreateArtistDto } from './../../../dto/artist-dto';
import { BehaviorSubject, filter } from 'rxjs';
import { BulkDto } from '../../../dto/bulk-dto';
import { CommandResult } from '../../../model/command-result';
import { ConfirmPopupModule } from 'primeng/confirmpopup';

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
    ConfirmPopupModule
  ],
  templateUrl: './artist-management.component.html',
  styleUrl: './artist-management.component.scss',
  providers: [MessageService, ArtistService, ConfirmationService, UrlValidator]
})
export class ArtistManagementComponent implements OnInit {
  readonly IS_PUBLIC_TRUE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_YES:Yes`;
  readonly IS_PUBLIC_FALSE: string = $localize`:@@COLUMN_CELL_VALUE_MANAGE_ARTIST_PUBLIC_NO:No`;
  private readonly newIds: Set<string> = new Set();
  private readonly newIdSubject = new BehaviorSubject<string | null>(null);
  readonly nameFormControl: FormControl = new FormControl<string>('', [Validators.required, Validators.maxLength(250)]);
  readonly descriptionFormControl: FormControl = new FormControl<string>('');
  readonly biographyFormControl: FormControl = new FormControl<string>('');
  readonly thumbnailUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly backgroundUrlFormControl: FormControl = new FormControl<string>('', [Validators.pattern(URL_REGEX)]);
  readonly nationalityIsoCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly isVerifiedFormControl: FormControl = new FormControl<boolean>(false);
  readonly tagsFormControl: FormControl = new FormControl<string[]>([]);
  readonly refCodeFormControl: FormControl = new FormControl<string | null>(null);
  readonly createArtistFormGroup: FormGroup = new FormGroup({
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
  readonly selectedArtistDtos: ArtistDto[] = [];
  readonly artistDtos: WritableSignal<ArtistDto[]> = signal<ArtistDto[]>([]);
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
    private readonly http: HttpClient
  ) {}

  ngOnInit(): void {
    this.newIdSubject.subscribe((newId) => {
      if (newId) {
        this.newIds.add(newId);
        if (this.newIds.size && this.fetchNewArtistIntervalId >= 0) {
          this.fetchNewArtistIntervalId = window.setTimeout(() => {
            this.artistService.getArtistByIds([...this.newIds]).subscribe((respDto) => {
              const newArtistDtos: ArtistDto[] = respDto.data;
              const newArtistDtosMap = new Map(newArtistDtos.map((newArtistDto) => [newArtistDto.id, newArtistDto]));
              newArtistDtos.forEach(
                (newArtistDto) => this.newIds.has(newArtistDto.id) && this.newIds.delete(newArtistDto.id)
              );
              if (!this.newIds.size) {
                window.clearInterval(this.fetchNewArtistIntervalId);
                this.fetchNewArtistIntervalId = -1;
              }
              this.artistDtos.update((artistDtos) => {
                const updatedArtistDtos: ArtistDto[] = artistDtos.map(
                  (artistDto) => newArtistDtosMap.get(artistDto.id) || artistDto
                );
                return updatedArtistDtos;
              });
            });
          }, 1000);
        }
      }
    });
    this.thumbnailUrlFormControl.valueChanges.subscribe(
      (value: string) => !this.thumbnailUrlFormControl.errors && this.processImagePreview(value)
    );
    this.backgroundUrlFormControl.valueChanges.subscribe(
      (value: string) => !this.backgroundUrlFormControl.errors && this.processImagePreview(value)
    );
    this.artistService.getMockArtists().subscribe((respDto: ResponseDto<ArtistDto[]>) => {
      this.artistDtos.set(respDto.data);
    });
  }

  hideArtistDialog(): void {
    this.isDialogShowed = false;
    this.isDialogFormSubmitted = false;
  }

  deleteSelectedArtists(): void {}

  exportCsv(): void {}

  onGlobalFilter(table: Table, event: Event) {
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }

  handleNewArtist(): void {
    this.editArtistId = null;
    this.openArtistDialog('new');
  }

  handleEditArtist({
    id,
    profile: { name, description, biography, thumbnailUrl, backgroundUrl, nationalityIsoCode },
    refCode
  }: ArtistDto): void {
    this.nameFormControl.setValue(name);
    this.descriptionFormControl.setValue(description);
    this.biographyFormControl.setValue(biography);
    this.backgroundUrlFormControl.setValue(backgroundUrl);
    this.nationalityIsoCodeFormControl.setValue(nationalityIsoCode);
    this.thumbnailUrlFormControl.setValue(thumbnailUrl);
    this.refCodeFormControl.setValue(refCode);
    this.editArtistId = id;
    this.openArtistDialog('edit');
  }

  handleSaveArtist(): void {
    if (this.action === 'new') {
      this.createArtist();
    } else if (this.action === 'edit') {
    }
  }

  handleDeleteArtist({ id }: ArtistDto): void {
    this.confirmationService.confirm({
      message: $localize`:@@CONFIRM_MESSAGE_ARTIST_DELETE:Are you sure you want to delete the selected products?`,
      header: 'Confirm',
      icon: 'pi pi-exclamation-triangle',
      // key: 'btn-delete-at-row',
      accept: () => {
        this.artistService.bulkDeleteArtist({ items: [{ id }] }).subscribe((respDto) => {
          this.messageService.add({
            severity: 'success',
            summary: $localize`:@@MESSAGE_SUCCESSFUL:Successful`,
            detail: $localize`:@@MESSAGE_ARTIST_DETELE_SUCCESSFUL:Artist was deleted successfully.`,
            life: 3000
          });
        });
      }
    });
  }

  private openArtistDialog(action: ActionType): void {
    if (this.action == action) {
      this.isDialogShowed = true;
      return;
    } else {
      this.action = action;
      this.isDialogFormSubmitted = false;
      this.isDialogShowed = true;
    }
  }

  private createArtist(): void {
    this.artistService
      .bulkCreateArtist({
        items: [
          {
            profile: {
              name: this.nameFormControl.value,
              description: this.descriptionFormControl.value,
              biography: this.biographyFormControl.value,
              nationalityIsoCode: this.nationalityIsoCodeFormControl.value || null,
              thumbnailUrl: this.thumbnailUrlFormControl.value.trim() || null,
              backgroundUrl: this.backgroundUrlFormControl.value.trim() || null
            },
            refCode: this.refCodeFormControl.value,
            isVerified: false,
            tags: []
          }
        ]
      })
      .subscribe((respDto) => {
        const { id, isSuccessful, errors }: CommandResult = respDto.data.items[0];
        if (isSuccessful) {
          id && this.newIds.add(id);
        } else {
          const businessRule = errors[0].businessRule;
          businessRule &&
            this.messageService.add({
              summary: businessRule.code,
              detail: businessRule.content,
              severity: 'error'
              // summary: 'string';
              // detail?: string;
              // id?: any;
              // key?: string;
              // life?: number;
              // sticky?: boolean;
              // closable?: boolean;
              // data?: any;
              // icon?: string;
              // contentStyleClass?: string;
              // styleClass?: string;
              // closeIcon?: string;
            });
        }
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
