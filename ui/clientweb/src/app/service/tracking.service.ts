import { Injectable } from '@angular/core';
import { ActivityService } from './activity.service';
import { Subject } from 'rxjs';
import { ActionType } from '../constant/action-type';
import { MessageType } from '../constant/message-type';
import { MessageResponseDto } from '../dto/activity-dto';

@Injectable({
  providedIn: 'root'
})
export class TrackingService {
  private readonly viewArtistDetailPageTrackingSubject: Subject<MessageResponseDto> = new Subject();
  private readonly viewTrackDetailPageTrackingSubject: Subject<MessageResponseDto> = new Subject();
  private readonly listenTrackTrackingSubject: Subject<MessageResponseDto> = new Subject();
  private isInitialized: boolean = false;

  constructor(private readonly activityService: ActivityService) {
    this.initialize();
  }

  initialize() {
    if (this.isInitialized) {
      return;
    }
    this.activityService.addMessageHandler(
      MessageType.PROCESSED_VIEW_ARTIST_DETAIL_PAGE_TRACKING,
      (message: MessageResponseDto) => this.handleViewArtistDetailPageMessage(message)
    );
    this.activityService.addMessageHandler(
      MessageType.PROCESSED_VIEW_TRACK_DETAIL_PAGE_TRACKING,
      (message: MessageResponseDto) => this.handleViewTrackDetailPageMessage(message)
    );
    this.activityService.addMessageHandler(MessageType.PROCESSED_LISTEN_TRACK_TRACKING, (message: MessageResponseDto) =>
      this.handleListenTrackMessage(message)
    );
    this.isInitialized = true;
  }

  startViewArtistDetailPageTracking(artistId: string) {
    this.activityService.sendMessage({
      aggregateId: artistId,
      type: ActionType.VIEW_ARTIST_DETAIL_PAGE_TRACKING,
      dataJson: null,
      sessionId: null
    });
  }

  sendViewedArtistDetailPageTracking(sessionId: string) {
    this.activityService.sendMessage({
      sessionId,
      aggregateId: null,
      type: ActionType.VIEWED_ARTIST_DETAIL_PAGE_TRACKING,
      dataJson: null
    });
  }

  startViewTrackDetailPageTracking(trackId: string) {
    this.activityService.sendMessage({
      aggregateId: trackId,
      type: ActionType.VIEW_TRACK_DETAIL_PAGE_TRACKING,
      dataJson: null,
      sessionId: null
    });
  }

  sendViewedTrackDetailPageTracking(sessionId: string) {
    this.activityService.sendMessage({
      sessionId,
      aggregateId: null,
      type: ActionType.VIEWED_TRACK_DETAIL_PAGE_TRACKING,
      dataJson: null
    });
  }

  startListenedTrackTracking(trackId: string) {
    this.activityService.sendMessage({
      aggregateId: trackId,
      type: ActionType.VIEW_TRACK_DETAIL_PAGE_TRACKING,
      dataJson: null,
      sessionId: null
    });
  }

  sendListenedTrackTracking(sessionId: string) {
    this.activityService.sendMessage({
      sessionId,
      aggregateId: null,
      type: ActionType.VIEWED_TRACK_DETAIL_PAGE_TRACKING,
      dataJson: null
    });
  }

  get viewArtistDetailPageTracking() {
    return this.viewArtistDetailPageTrackingSubject.asObservable();
  }

  get viewTrackDetailPageTracking() {
    return this.viewTrackDetailPageTrackingSubject.asObservable();
  }

  get listenTrackTracking() {
    return this.listenTrackTrackingSubject.asObservable();
  }

  private handleViewArtistDetailPageMessage(message: MessageResponseDto) {
    this.viewArtistDetailPageTrackingSubject.next(message);
  }

  private handleViewTrackDetailPageMessage(message: MessageResponseDto) {
    this.viewTrackDetailPageTrackingSubject.next(message);
  }

  private handleListenTrackMessage(message: MessageResponseDto) {
    this.listenTrackTrackingSubject.next(message);
  }
}
