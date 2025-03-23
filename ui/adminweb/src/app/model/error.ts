import { BusinessRule } from './business-rule';

export interface Error {
  businessRule: BusinessRule | null;
  message: string | null;
  object: string | null;
}
