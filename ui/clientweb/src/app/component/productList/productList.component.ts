import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ButtonModule } from 'primeng/button';

interface DiscographyItem {
  thumbnail: string;
  name: string;
  info: string;
}

@Component({
  selector: 'product-list',
  standalone: true,
  imports: [CommonModule, ButtonModule],
  templateUrl: './productList.component.html',
  styleUrls: ['./productList.component.scss']
})
export class productList {
  @Input() items: DiscographyItem[] = [];
  @Input() showAll = false;
  @Input() title = 'Discography'; // Added title input with default value
  @Input() circularThumbnails = false; // Control whether thumbnails are circular or default rectangular
  @Output() toggleShowAll = new EventEmitter<void>();

  // Number of items to show when not showing all
  @Input() defaultItemCount = 7;

  get visibleItems(): DiscographyItem[] {
    return this.showAll ? this.items : this.items.slice(0, this.defaultItemCount);
  }

  handleOnToggleShowAll(): void {
    this.toggleShowAll.emit();
  }
}
