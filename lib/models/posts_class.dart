class Posts {
  Posts(this.postsTitle, this.postsBody, this.PostsRefNum, this.postsOwnerId,this.postsDate);

  final String postsTitle;
  final String postsBody;
  final String PostsRefNum;
  final String postsOwnerId;
  final String postsDate;

  String getTitle() {
    return postsTitle;
  }

  String getBody() {
    return postsBody;
  }

  String getRefNum() {
    return PostsRefNum;
  }

  String getOwnerId() {
    return postsOwnerId;
  }
  String getDate() {
    return postsDate;
  }
}