import { BusinessRule } from '../model/business-rule';

export interface Error {
  businessRule: BusinessRule | null;
  message: string | null;
  object: string | null;
}
