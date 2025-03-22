import { Artist } from './../../../dto/artist-dto';
import { Component, OnInit, signal, ViewChild } from '@angular/core';
import { ArtistService } from '../../../service/artist.service';
import { Table, TableModule } from 'primeng/table';
import { ConfirmationService, MessageService } from 'primeng/api';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { RippleModule } from 'primeng/ripple';
import { ToastModule } from 'primeng/toast';
import { ToolbarModule } from 'primeng/toolbar';
import { RatingModule } from 'primeng/rating';
import { InputTextModule } from 'primeng/inputtext';
import { TextareaModule } from 'primeng/textarea';
import { SelectModule } from 'primeng/select';
import { RadioButtonModule } from 'primeng/radiobutton';
import { InputNumberModule } from 'primeng/inputnumber';
import { DialogModule } from 'primeng/dialog';
import { TagModule } from 'primeng/tag';
import { InputIconModule } from 'primeng/inputicon';
import { IconFieldModule } from 'primeng/iconfield';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { EditorModule } from 'primeng/editor';
import { ARTIST_NATIONALITIES } from '../../../constant/constant';
import { HttpClient } from '@angular/common/http';
import { UrlValidator } from '../../../validator/url.validator';

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
    EditorModule
  ],
  templateUrl: './artist-management.component.html',
  styleUrl: './artist-management.component.scss',
  providers: [MessageService, ArtistService, ConfirmationService, UrlValidator]
})
export class ArtistManagementComponent implements OnInit {
  productDialog: boolean = false;
  products = signal<Artist[]>([]);
  product!: Artist;
  selectedProducts!: Artist[] | null;
  submitted: boolean = false;
  statuses!: any[];
  @ViewChild('dt') dt!: Table;
  exportColumns!: ExportColumn[];
  cols!: Column[];

  isUpdate: boolean = false;

  countries: any[] | undefined;
  selectedCountry: string | undefined;

  thumbnailUrlValid: boolean = false;
  backgroundUrlValid: boolean = false;

  constructor(
    private artistService: ArtistService,
    private messageService: MessageService,
    private confirmationService: ConfirmationService,
    private http: HttpClient,
    private urlValidator: UrlValidator
  ) {}

  ngOnInit() {
    this.loadDemoData();
    this.countries = ARTIST_NATIONALITIES;
  }

  exportCSV() {
    this.dt.exportCSV();
  }

  loadDemoData() {
    this.artistService.getProducts().then((data) => {
      this.products.set(data);
    });

    this.statuses = [
      { label: 'INSTOCK', value: 'instock' },
      { label: 'LOWSTOCK', value: 'lowstock' },
      { label: 'OUTOFSTOCK', value: 'outofstock' }
    ];

    this.cols = [
      { field: 'ref_code', header: 'Reference Code' },
      { field: 'profile.name', header: 'Name' },
      { field: 'profile.biography', header: 'Biography' },
      { field: 'profile.description', header: 'Description' },
      { field: 'profile.thumbnailUrl', header: 'Thumbnail' },
      { field: 'profile.backgroundUrl', header: 'Background' }
    ];

    this.exportColumns = this.cols.map((col) => ({ title: col.header, dataKey: col.field }));
  }

  onGlobalFilter(table: Table, event: Event) {
    table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
  }

  openNew() {
    this.product = {
      id: '',
      urn: '',
      ref_code: '',
      profile: {
        name: '',
        biography: '',
        description: '',
        thumbnailUrl: '',
        backgroundUrl: '',
        thumbnailFileKey: null,
        backgroundFileKey: null
      },
      isPublic: false,
      tags: []
    };
    this.submitted = false;
    this.productDialog = true;
    this.isUpdate = false;
  }

  editProduct(product: Artist) {
    this.product = structuredClone(product);
    this.productDialog = true;
    this.isUpdate = true;
  }

  deleteSelectedProducts() {
    this.confirmationService.confirm({
      message: 'Are you sure you want to delete the selected products?',
      header: 'Confirm',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        this.products.set(this.products().filter((val) => !this.selectedProducts?.includes(val)));
        this.selectedProducts = null;
        this.showMessage('success', 'Successful', 'Products Deleted');
      }
    });
  }

  hideDialog() {
    this.productDialog = false;
    this.submitted = false;
    this.isUpdate = false;
  }

  deleteProduct(product: Artist) {
    this.confirmationService.confirm({
      message: 'Are you sure you want to delete ' + product.profile.name + '?',
      header: 'Confirm',
      icon: 'pi pi-exclamation-triangle',
      accept: () => {
        this.products.set(this.products().filter((val) => val.id !== product.id));
        this.product = {
          id: '',
          urn: '',
          ref_code: '',
          profile: {
            name: '',
            biography: '',
            description: '',
            thumbnailUrl: '',
            backgroundUrl: '',
            thumbnailFileKey: null,
            backgroundFileKey: null
          },
          isPublic: false,
          tags: []
        };
        this.showMessage('success', 'Successful', 'Product Deleted');
      }
    });
  }

  findIndexById(id: string): number {
    let index = -1;
    for (let i = 0; i < this.products().length; i++) {
      if (this.products()[i].id === id) {
        index = i;
        break;
      }
    }

    return index;
  }

  createId(): string {
    let id = '';
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    for (var i = 0; i < 5; i++) {
      id += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return id;
  }

  getSeverity(status: string) {
    if (status) {
      return 'success';
    }
    return 'danger';
  }

  async saveProduct() {
    this.submitted = true;

    // Validate required fields
    if (!this.product.profile.name?.trim() || !this.product.profile.biography?.trim() || !this.product.profile.description?.trim() || !this.product.profile.thumbnailUrl?.trim() || !this.product.profile.backgroundUrl?.trim()) {
      return;
    }

    // Check if URLs exist
    this.urlValidator.checkUrlImage(this.product.profile.thumbnailUrl).subscribe(isValid => {
      this.thumbnailUrlValid = isValid;
    });
    this.urlValidator.checkUrlImage(this.product.profile.backgroundUrl).subscribe(isValid => {
      this.backgroundUrlValid = isValid;
    });
    if (!this.thumbnailUrlValid || !this.backgroundUrlValid) {
      this.showMessage('error', 'URL Not Found', 'One or both URLs do not exist.');
      return;
    }

    let _products = this.products();
    if (this.product.profile.name?.trim()) {
      if (this.product.id) {
        console.log('update existing artist');
        // Update existing artist
        const index = this.findIndexById(this.product.id);
        if (index !== -1) {
          _products[index] = this.product;
          this.products.set([..._products]);
          this.showMessage('success', 'Successful', 'Product Updated');
        }
      } else {
        console.log('create new artist');
        this.product.id = this.createId();
        this.product.ref_code = 'PD' + Date.now().toLocaleString();
        this.product.profile.thumbnailUrl = this.product.profile.thumbnailUrl;
        this.product.profile.backgroundUrl = this.product.profile.backgroundUrl;
        this.product.profile.biography = this.product.profile.biography;
        this.product.profile.description = this.product.profile.description;
        this.product.profile.name = this.product.profile.name;

        this.showMessage('success', 'Successful', 'Product Created');

        this.products.set([..._products, this.product]);
      }

      this.productDialog = false;
      this.product = {
        id: '',
        urn: '',
        ref_code: '',
        profile: {
          name: '',
          biography: '',
          description: '',
          thumbnailUrl: '',
          backgroundUrl: '',
          thumbnailFileKey: null,
          backgroundFileKey: null
        },
        isPublic: false,
        tags: []
      };
    }
  }

  checkUrls(): void {
    if (this.product.profile.thumbnailUrl) {
      this.urlValidator.checkUrl(this.product.profile.thumbnailUrl).subscribe(isValid => {
        this.thumbnailUrlValid = isValid;
      });
    }

    if (this.product.profile.backgroundUrl) {
      this.urlValidator.checkUrl(this.product.profile.backgroundUrl).subscribe(isValid => {
        this.backgroundUrlValid = isValid;
      });
    }
  }

  showMessage(type: string, summary: string, detail: string) {
    this.messageService.add({ severity: type, summary: summary, detail: detail, key: 'br', life: 3000 });
  }
}
