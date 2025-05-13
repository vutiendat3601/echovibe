import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'audioDurationPipe'
})
export class AudioDurationPipe implements PipeTransform {
  transform(durationSecond: number | null): string {
    if (durationSecond) {
      const minutes = Math.floor(durationSecond / 60);
      const seconds = Math.floor(durationSecond % 60);
      return `${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
    }
    return `00:00`;
  }
}
