package vn.io.echovibe.artist.command.dto;

import vn.io.echovibe.core.annotation.IsoCountryCode;

public record ChangeArtistMarketDto(
    @IsoCountryCode(message = "Field 'market' must match ISO 3166-1 Alpha-2 Country Code")
        String market) {}
