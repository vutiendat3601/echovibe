export interface ResourceAccess {
  roles: string[];
}
export interface ResourceAccessClaim {
  [key: string]: ResourceAccess;
}

export const EMPTY_RESOURCE_ACCESS: ResourceAccess = { roles: [] };
