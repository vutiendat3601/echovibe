import { CommonModule } from '@angular/common';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay } from '@fortawesome/free-solid-svg-icons';
import { BadgeModule } from 'primeng/badge';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { ProgressBarModule } from 'primeng/progressbar';
import { ProductList } from '../../../component/productList/productList.component';
import { ArtistDetailDto } from '../../../dto/artist-dto';
import { ResponseDto } from '../../../dto/response-dto';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { AudioDurationPipe } from '../../../pipe/audio-duration.pipe';
import { ActivityService } from '../../../service/activity.service';
import { TrackingService } from '../../../service/tracking.service';
import { MessageResponseDto } from './../../../dto/activity-dto';
import { ArtistService } from './../../../service/artist.service';
import { TrackService } from '../../../service/track.service';

interface ArtistStats {
  totalDetailPageViews: number;
  totalLikes: number;
  mostPopularTracks: {
    id: string;
    name: string;
    audioFileM3u8Url: string | null;
    audioDurationSecond: number | null;
    totalListens: number;
    totalLikes: number;
  }[];
}

interface ArtistDetail {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  isPublic: boolean;
  isVerified: boolean;
  tags: string[];
  stats: ArtistStats;
}

@Component({
  selector: 'app-artist-detail',
  standalone: true,
  imports: [
    CommonModule,
    ProgressBarModule,
    BadgeModule,
    CardModule,
    ButtonModule,
    FontAwesomeModule,
    ProductList,
    RouterModule,
    SafeHtmlPipe,
    AudioDurationPipe
  ],
  templateUrl: './artist-detail.component.html',
  styleUrl: './artist-detail.component.scss',
  providers: [ActivityService]
})
export class ArtistDetailComponent implements OnInit, OnDestroy {
  viewArtistDetailTrackingSessionId: string | null = null;
  artistDetail: ArtistDetail | null = null;
  artistJson: string | null = null;
  value = 0;
  showAll = false;
  showAllDiscography = false;
  discography = [
    {
      thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg',
      name: 'Chúng Ta Của Hiện Tại',
      info: 'Single • 2020'
    },
    {
      thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg',
      name: 'Có Chắc Yêu Là Đây',
      info: 'Single • 2020'
    },
    {
      thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg',
      name: 'Hãy Trao Cho Anh',
      info: 'Single • 2019'
    },
    { thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg', name: 'Chạy Ngay Đi', info: 'Single • 2018' },
    { thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg', name: 'Lạc Trôi', info: 'Single • 2017' },
    {
      thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg',
      name: 'Nơi Này Có Anh',
      info: 'Single • 2017'
    },
    {
      thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg',
      name: 'Âm Thầm Bên Em',
      info: 'Single • 2015'
    },
    {
      thumbnail: 'https://static.znews.vn/static/topic/person/messi.jpg',
      name: 'Cơn Mưa Ngang Qua',
      info: 'Single • 2013'
    }
  ];
  // Icons from FontAwesome
  faPlay = faPlay;

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly artistService: ArtistService,
    private readonly router: Router,
    private readonly trackingService: TrackingService,
    private readonly trackService: TrackService
  ) {}

  ngOnInit(): void {
    this.loadData();
    this.listenTrackingEvent();
  }

  ngOnDestroy(): void {
    this.destroy();
  }

  toggleShowAll(): void {
    this.showAll = !this.showAll;
  }

  toggleShowAllDiscography(): void {
    this.showAllDiscography = !this.showAllDiscography;
  }

  private listenTrackingEvent() {
    this.trackingService.viewArtistDetailPageTracking.subscribe(({ sessionId, aggregateId }: MessageResponseDto) => {
      if (this.artistDetail && aggregateId === this.artistDetail.id && sessionId) {
        this.viewArtistDetailTrackingSessionId = sessionId;
        window.setTimeout(() => {
          this.trackingService.sendViewedArtistDetailPageTracking(sessionId);
        }, 5_000);
      }
    });
  }

  private loadData(): void {
    this.activeRoute.params.subscribe((params) => {
      if (params['id']) {
        this.artistService.getArtistById(params['id']).subscribe((respDto: ResponseDto<ArtistDetailDto | null>) => {
          if (respDto.data) {
            const artistDetailDto = respDto.data;
            if (artistDetailDto) {
              const artistDetail = this.mapToArtistDetail(artistDetailDto);
              const stats = artistDetail.stats;
              this.artistService.getArtistStats(artistDetail.id).subscribe((respDto) => {
                const {
                  totalDetailPageViews,
                  totalLikes,
                  mostListenedTrackIds,
                  mostListenedTrackIdsCurrentMonth,
                  mostPopularTrackIds
                } = respDto.data;
                stats.totalDetailPageViews = totalDetailPageViews;
                stats.totalLikes = totalLikes;

                const trackIds = [...mostListenedTrackIds, ...mostListenedTrackIdsCurrentMonth, ...mostPopularTrackIds];
                trackIds.length &&
                  this.trackService.getTrackByIds(trackIds).subscribe((respDto) => {
                    const trackDetailDtos = respDto.data.filter((td) => td != null);
                    const trackDetailDtosMap = new Map(trackDetailDtos.map((td) => [td.id, td]));
                    if (this.artistDetail) {
                      stats.mostPopularTracks = mostPopularTrackIds
                        .map((id) => {
                          const trackDetailDto = trackDetailDtosMap.get(id);
                          if (trackDetailDto) {
                            const { id, name, audioDurationSecond, audioFileM3u8Url } = trackDetailDto;
                            const track = {
                              id,
                              name,
                              audioDurationSecond,
                              audioFileM3u8Url,
                              totalListens: 0,
                              totalLikes: 0
                            };
                            return track;
                          }
                          return null;
                        })
                        .filter((t) => t != null);

                      this.trackService.getTrackStatsByIds(trackIds).subscribe((respDto) => {
                        const trackStatsDtos = respDto.data.filter((ts) => ts != null);
                        const trackStatsDtosMap = new Map(trackStatsDtos.map((ts) => [ts.id, ts]));
                        if (this.artistDetail) {
                          this.artistDetail.stats.mostPopularTracks.forEach((track) => {
                            const trackStatsDto = trackStatsDtosMap.get(track.id);
                            if (trackStatsDto) {
                              track.totalLikes = trackStatsDto.totalLikes;
                              track.totalListens = trackStatsDto.totalListens;
                            }
                          });
                        }
                      });
                    }
                  });
              });
              this.artistDetail = artistDetail;
              this.initializeTracking();
            }
          } else {
            this.router.navigate(['/not-found']);
          }
        });
      } else {
        this.router.navigate(['/not-found']);
      }
    });
  }

  private initializeTracking() {
    if (this.artistDetail) {
      this.trackingService.startViewArtistDetailPageTracking(this.artistDetail.id);
    }
  }

  private mapToArtistDetail(artistDto: ArtistDetailDto): ArtistDetail {
    const {
      id,
      urn,
      name,
      description,
      biography,
      nationalityIsoCode,
      thumbnailUrl,
      backgroundUrl,
      isPublic,
      isVerified,
      tags
    } = artistDto;
    return {
      id,
      urn,
      name,
      description,
      biography,
      nationalityIsoCode,
      thumbnailUrl,
      backgroundUrl,
      isPublic,
      isVerified,
      tags,
      stats: { totalDetailPageViews: 0, totalLikes: 0, mostPopularTracks: [] }
    };
  }

  private destroy() {
    this.viewArtistDetailTrackingSessionId &&
      this.trackingService.sendViewedArtistDetailPageTracking(this.viewArtistDetailTrackingSessionId);
  }
}
