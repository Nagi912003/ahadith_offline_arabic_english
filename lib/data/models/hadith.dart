class Hadith {
  int? id;
  String? titleAr;
  String? title;
  String? hadithTextAr;
  String? hadithText;
  String? explanationAr;
  String? explanation;
  String? benefitsAr;
  String? benefits;
  String? gradeAr;
  String? takhrijAr;
  String? grade;
  String? takhrij;
  String? lang;
  String? link;

  Hadith(
      {this.id,
        this.titleAr,
        this.title,
        this.hadithTextAr,
        this.hadithText,
        this.explanationAr,
        this.explanation,
        this.benefitsAr,
        this.benefits,
        this.gradeAr,
        this.takhrijAr,
        this.grade,
        this.takhrij,
        this.lang,
        this.link});

  Hadith.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    title = json['title'];
    hadithTextAr = json['hadith_text_ar'];
    hadithText = json['hadith_text'];
    explanationAr = json['explanation_ar'];
    explanation = json['explanation'];
    benefitsAr = json['benefits_ar'];
    benefits = json['benefits'];
    gradeAr = json['grade_ar'];
    takhrijAr = json['takhrij_ar'];
    grade = json['grade'];
    takhrij = json['takhrij'];
    lang = json['lang'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title'] = this.title;
    data['hadith_text_ar'] = this.hadithTextAr;
    data['hadith_text'] = this.hadithText;
    data['explanation_ar'] = this.explanationAr;
    data['explanation'] = this.explanation;
    data['benefits_ar'] = this.benefitsAr;
    data['benefits'] = this.benefits;
    data['grade_ar'] = this.gradeAr;
    data['takhrij_ar'] = this.takhrijAr;
    data['grade'] = this.grade;
    data['takhrij'] = this.takhrij;
    data['lang'] = this.lang;
    data['link'] = this.link;
    return data;
  }
}
