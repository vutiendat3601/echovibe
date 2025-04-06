import { Pipe, PipeTransform } from '@angular/core';
import { SafeHtml, DomSanitizer } from '@angular/platform-browser';

@Pipe({
  name: 'safeHtmlPipe'
})
export class SafeHtmlPipe implements PipeTransform {
  constructor(private readonly domSanitizer: DomSanitizer) {}

  transform(value: string | null): SafeHtml {
    return this.domSanitizer.bypassSecurityTrustHtml(value || '');
  }
}
