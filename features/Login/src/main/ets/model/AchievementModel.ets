/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export class AchieveImage {
  pathId: string = '';
  activeImage?: Resource;
  defaultImage?: Resource;
  lottiePath: string = '';
}

export const ACHIEVE_IMAGE_LIST: AchieveImage[] = [
  {
    pathId: '1',
    activeImage: $r('app.media.learning_path_1_completed'),
    defaultImage: $r('app.media.learning_path_1_default'),
    lottiePath: 'common/lottie/learning_path_1_lottie.json'
  },
  {
    pathId: '2',
    activeImage: $r('app.media.learning_path_2_completed'),
    defaultImage: $r('app.media.learning_path_2_default'),
    lottiePath: 'common/lottie/learning_path_2_lottie.json'
  },
  {
    pathId: '3',
    activeImage: $r('app.media.learning_path_3_completed'),
    defaultImage: $r('app.media.learning_path_3_default'),
    lottiePath: 'common/lottie/learning_path_3_lottie.json'
  },
  {
    pathId: '4',
    activeImage: $r('app.media.learning_path_4_completed'),
    defaultImage: $r('app.media.learning_path_4_default'),
    lottiePath: 'common/lottie/learning_path_4_lottie.json'
  },
  {
    pathId: '5',
    activeImage: $r('app.media.learning_path_5_completed'),
    defaultImage: $r('app.media.learning_path_5_default'),
    lottiePath: 'common/lottie/learning_path_5_lottie.json'
  },
  {
    pathId: '6',
    activeImage: $r('app.media.learning_path_6_completed'),
    defaultImage: $r('app.media.learning_path_6_default'),
    lottiePath: 'common/lottie/learning_path_6_lottie.json'
  }
];