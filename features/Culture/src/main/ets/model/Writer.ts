/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 * Generated by the CloudDB ObjectType compiler. DO NOT EDIT!
 */
import { cloudDatabase } from '@kit.CloudFoundationKit';

class Writer extends cloudDatabase.DatabaseObject {
  id: string;
  name: string;
  simpleIntro: string;

  naturalbase_ClassName(): string {
    return 'Writer';
  }
}

export { Writer };