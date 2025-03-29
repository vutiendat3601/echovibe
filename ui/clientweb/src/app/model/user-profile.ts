export interface UserProfile {
  info?: {
    exp?: number;
    iat?: number;
    auth_time?: number;
    jti?: string;
    iss?: string;
    aud?: string;
    sub?: string;
    typ?: string;
    azp?: string;
    nonce?: string;
    sid?: string;
    at_hash?: string;
    acr?: string;
    email_verified: true;
    name?: string;
    preferred_username?: string;
    given_name?: string;
    family_name?: string;
    picture?: string;
    email: string;
  };
}
