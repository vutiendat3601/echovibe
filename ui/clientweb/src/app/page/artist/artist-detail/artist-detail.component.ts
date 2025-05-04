import { ArtistService } from './../../../service/artist.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ResponseDto } from '../../../dto/response-dto';
import { ArtistDetailDto } from '../../../dto/artist-dto';
import { CommonModule } from '@angular/common';
import { ProgressBarModule } from 'primeng/progressbar';
import { BadgeModule } from 'primeng/badge';
import { CardModule } from 'primeng/card';
import { ButtonModule } from 'primeng/button';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay } from '@fortawesome/free-solid-svg-icons';
import { productList } from '../../../component/productList/productList.component';
import { SafeHtmlPipe } from '../../../pipe/safe-html.pipe';
import { ActivityService } from '../../../service/activity.service';
import { ActionType } from '../../../constant/action-type';

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
export class ArtistDetailComponent implements OnInit {
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
    private acitivityService: ActivityService
  ) {}

  ngOnInit(): void {
    this.loadData();
    this.listenActivityEvent();
  }

  toggleShowAll(): void {
    this.showAll = !this.showAll;
  }

  toggleShowAllDiscography(): void {
    this.showAllDiscography = !this.showAllDiscography;
  }

  private listenActivityEvent() {
    this.acitivityService.websocketMessage.subscribe((text) => {
      const activityResp = JSON.parse(text);
      if (activityResp?.type === ActionType.VIEW_ARTIST_DETAIL_PAGE) {
        setTimeout(() => {
          this.acitivityService.send({
            sessionId: activityResp?.sessionId || null,
            aggregateId: this.artist?.id || null,
            type: ActionType.VIEWED_ARTIST_DETAIL_PAGE,
            dataJson: null
          });
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
            this.acitivityService.send({
              sessionId: null,
              aggregateId: this.artist.id,
              type: ActionType.VIEW_ARTIST_DETAIL_PAGE,
              dataJson: null
            });
          } else {
            this.router.navigate(['/not-found']);
          }
        });
      } else {
        this.router.navigate(['/not-found']);
      }
    });
  }
}
