import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ActionType } from '../constant/action-type';
import { MessageType } from '../constant/message-type';
import { MessageResponseDto } from '../dto/activity-dto';
import { PlaylistDetailDto } from '../dto/playlist-dto';
import { ResponseDto } from '../dto/response-dto';
import { CreatePlaylistDto, UpdatePlaylistDto } from './../dto/playlist-dto';
import { ActivityService } from './activity.service';

@Injectable({
  providedIn: 'root'
})
export class PlaylistService {
  private readonly createdPlaylistIdSubject: Subject<string> = new Subject();

  constructor(
    private readonly activityService: ActivityService,
    private readonly http: HttpClient
  ) {
    this.registerActivityMessageHandler();
  }

  createPlaylist(createPlaylistDto: CreatePlaylistDto): void {
    this.activityService.sendMessage({
      aggregateId: null,
      sessionId: null,
      type: ActionType.CREATE_PLAYLIST,
      dataJson: createPlaylistDto
    });
  }

  updatePlaylist(updatePlaylistDto: UpdatePlaylistDto): void {
    this.activityService.sendMessage({
      aggregateId: updatePlaylistDto.id,
      sessionId: null,
      type: ActionType.UPDATE_PLAYLIST,
      dataJson: updatePlaylistDto
    });
  }

  deletePlaylist(id: string): void {
    this.activityService.sendMessage({
      aggregateId: id,
      sessionId: null,
      type: ActionType.DELETE_PLAYLIST,
      dataJson: null
    });
  }

  getPlaylistById(id: string): Observable<ResponseDto<PlaylistDetailDto | null>> {
    return this.http.get<ResponseDto<PlaylistDetailDto | null>>(`${environment.productBaseUrl}/v1/playlists/${id}`);
  }

  getPlaylistByIds(ids: string[]): Observable<ResponseDto<PlaylistDetailDto[]>> {
    return this.http.get<ResponseDto<PlaylistDetailDto[]>>(
      `${environment.productBaseUrl}/v1/playlists?ids=${ids.join(',')}`
    );
  }

  get createdPlaylistId() {
    return this.createdPlaylistIdSubject.asObservable();
  }

  private registerActivityMessageHandler() {
    this.activityService.addMessageHandler(MessageType.PROCESSED_CREATE_PLAYLIST, (message: MessageResponseDto) =>
      this.handlePlaylistCreatedEvent(message)
    );
  }

  private handlePlaylistCreatedEvent({ aggregateId }: MessageResponseDto) {
    aggregateId && this.createdPlaylistIdSubject.next(aggregateId);
  }
}
