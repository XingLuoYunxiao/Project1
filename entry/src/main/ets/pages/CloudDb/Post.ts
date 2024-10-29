import { cloudDatabase } from '@kit.CloudFoundationKit';

class Post extends cloudDatabase.DatabaseObject {
    id: number;
    userId: string = '';
    content: string = '';
    name: string;
    profilePicture: string;
    insertDate: Date;
    likes: string = '[]';
    likeCount: number = 0;

    naturalbase_ClassName(): string {
        return 'Post';
    }
}

export { Post };