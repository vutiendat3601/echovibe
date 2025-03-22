import { Injectable } from '@angular/core';
import { environment } from '../../environment/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CreateArtistDto } from '../dto/artist-dto';
import { ResponseDto } from '../dto/response-dto';
import { BulkResult } from '../model/bulk-result';
import { BulkDto } from '../dto/bulk-dto';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  constructor(private readonly http: HttpClient) {}

  createArtist(bulkCreateArtistDtos: BulkDto<CreateArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http.post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-create`, bulkCreateArtistDtos);
  }

  getProductsData() {
    return [
      {
        id: 'tPye9pizwpcU',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU1',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Jack 97',
          biography: 'Ca Jack 97',
          description: 'Ca sĩ Jack 97',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU2',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU3',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU4',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU5',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU6',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'A M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU7',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU8',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: true,
        tags: []
      },
      {
        id: 'tPye9pizwpcU9',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: true,
        tags: []
      },
      {
        id: 'tPye9pizwpcU10',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      },
      {
        id: 'tPye9pizwpcU11',
        urn: 'echovibe:artist:tPye9pizwpcU',
        ref_code: 'spt_5dfZ5uSmzR7VQK0udbAVpf',
        profile: {
          name: 'Sơn Tùng M-TP',
          biography: 'Ca sĩ Sơn Tùng M-TP',
          description: 'Ca sĩ Sơn Tùng M-TP',
          thumbnailFileKey: null,
          thumbnailUrl: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg',
          backgroundFileKey: null,
          backgroundUrl: 'https://cdn.tgdd.vn//GameApp/1353930//58-800x450.jpg'
        },
        isPublic: false,
        tags: []
      }
    ];
  }

  getProducts() {
    return Promise.resolve(this.getProductsData());
  }
}
