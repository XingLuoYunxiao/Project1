/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 * Generated by the CloudDB ObjectType compiler. DO NOT EDIT!
 */
import { cloudDatabase } from '@kit.CloudFoundationKit';

class Idiom extends cloudDatabase.DatabaseObject {
  id: number;
  word: string;
  abbr: string;
  data: string;

  naturalbase_ClassName(): string {
    return 'Idiom';
  }
}

export { Idiom };


