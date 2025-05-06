import { CommonModule } from '@angular/common';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay } from '@fortawesome/free-solid-svg-icons';
import { BadgeModule } from 'primeng/badge';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { ProgressBarModule } from 'primeng/progressbar';
import { productList } from '../../../component/productList/productList.component';
import { ArtistDetailDto } from '../../../dto/artist-dto';
import { ResponseDto } from '../../../dto/response-dto';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ActivityService } from '../../../service/activity.service';
import { TrackingService } from '../../../service/tracking.service';
import { MessageResponseDto } from './../../../dto/activity-dto';
import { ArtistService } from './../../../service/artist.service';

interface Artist {
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
    productList,
    SafeHtmlPipe
  ],
  templateUrl: './artist-detail.component.html',
  styleUrl: './artist-detail.component.scss',
  providers: [ActivityService]
})
export class ArtistDetailComponent implements OnInit, OnDestroy {
  viewArtistDetailTrackingSessionId: string | null = null;
  artist: Artist | null = null;
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
    private readonly trackingService: TrackingService
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
      if (this.artist && aggregateId === this.artist.id && sessionId) {
        this.viewArtistDetailTrackingSessionId = sessionId;
        window.setTimeout(() => {
          this.trackingService.sendViewedArtistDetailPageTracking(sessionId);
        }, 10_000);
      }
    });
  }

  private loadData(): void {
    this.activeRoute.params.subscribe((params) => {
      if (params['id']) {
        this.artistService.getArtistById(params['id']).subscribe((respDto: ResponseDto<ArtistDetailDto | null>) => {
          if (respDto.data) {
            this.artist = respDto.data;
            this.trackingService.startViewArtistDetailPageTracking(this.artist.id);
          } else {
            this.router.navigate(['/not-found']);
          }
        });
      } else {
        this.router.navigate(['/not-found']);
      }
    });
  }

  private destroy() {
    this.viewArtistDetailTrackingSessionId &&
      this.trackingService.sendViewedArtistDetailPageTracking(this.viewArtistDetailTrackingSessionId);
  }
}
