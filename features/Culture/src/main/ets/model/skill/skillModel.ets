import {
  ceramicArtForms,
  ceramicMakingProcesses,
  metalArtForms,
  metalMakingProcesses,
  silkArtForms,
  silkMakingProcesses
} from "./ProcAndForms";

// 定义传统技艺的基本接口
export interface TraditionalCraft {
  name: string; // 技艺名称
  description: string; // 技艺描述
  region: string; // 主要产地
  makingProcesses: MakingProcess[]
  artForms: ArtForm[]
}

// 制作工艺类
export interface MakingProcess {
  name: string; // 工艺名称
  description: string; // 工艺描述
}

// 艺术形式类
export interface ArtForm {
  name: string; // 艺术形式名称
  description: string; // 艺术形式描述
}

// 创建陶瓷艺术实例
export const ceramicArt: TraditionalCraft = {
  name: '陶瓷艺术',
  description: '景德镇瓷器的制作工艺，历经千年，享誉世界。',
  region: '景德镇',
  makingProcesses: ceramicMakingProcesses,
  artForms: ceramicArtForms
}

// 创建丝绸织造实例
export const silkWeaving: TraditionalCraft = {
  name: '丝绸织造',
  description: '介绍古代的丝绸制造和织锦技术。',
  region: '苏州、杭州等地',
  makingProcesses: silkMakingProcesses,
  artForms: silkArtForms
};

// 创建金属工艺实例
export const metalCraft: TraditionalCraft = {
  name: '金属工艺',
  description: '包括青铜器、金银器皿的制作。',
  region: '中原、北方等地',
  makingProcesses: metalMakingProcesses,
  artForms: metalArtForms
};

