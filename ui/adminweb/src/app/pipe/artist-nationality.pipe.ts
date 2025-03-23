import { ArtistNationality } from '../constant/constant';
import { Nationality } from './../model/nationality';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'artistNationalityName'
})
export class ArtistNationalityPipe implements PipeTransform {
  transform(nationalityIsoCode: string | null): string {
    // TODO: Find a way to transform COUNTRY ISO CODE
    if (nationalityIsoCode === 'VN') {
      return $localize`:@@COUNTRY_ISO_NAME_VN:`;
    }
    return $localize`:@@VALUE_UNDEFINED:`;
  }
}
