export class Attraction {
    id: number;
    name: string;
    image: Resource;
    description?: string;
    category?: string;
    constructor(id: number, name: string, image: Resource, description?: string) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.description = description;
    }
}
