// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.success,
    // required this.errors,
    required this.data,
  });

  bool success;
  // List<Error> errors;
  Data data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    success: json["success"],
    // errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    // "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    // required this.version,
    // required this.content,
    // required this.language,
    // required this.paragraphs,
    // required this.sentences,
    // required this.phrases,
    // required this.tokens,
    // required this.mainSentences,
    required this.mainPhrases,
    required this.mainLemmas,
    // required this.mainSyncons,
    // required this.entities,
    // required this.topics,
    // required this.knowledge,
    // required this.sentiment,
    // required this.relations,
  });

  // String version;
  // String content;
  // String language;
  // List<Paragraph> paragraphs;
  // List<Sentence> sentences;
  // List<Phrase> phrases;
  // List<Token> tokens;
  // List<MainSentence> mainSentences;
  List<Main> mainPhrases;
  List<Main> mainLemmas;
  // List<MainSyncon> mainSyncons;
  // List<Entity> entities;
  // List<Topic> topics;
  // List<Knowledge> knowledge;
  // Sentiment sentiment;
  // List<Relation> relations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    // version: json["version"],
    // content: json["content"],
    // language: json["language"],
    // paragraphs: List<Paragraph>.from(json["paragraphs"].map((x) => Paragraph.fromJson(x))),
    // sentences: List<Sentence>.from(json["sentences"].map((x) => Sentence.fromJson(x))),
    // phrases: List<Phrase>.from(json["phrases"].map((x) => Phrase.fromJson(x))),
    // tokens: List<Token>.from(json["tokens"].map((x) => Token.fromJson(x))),
    // mainSentences: List<MainSentence>.from(json["mainSentences"].map((x) => MainSentence.fromJson(x))),
    mainPhrases: List<Main>.from(json["mainPhrases"].map((x) => Main.fromJson(x))),
    mainLemmas: List<Main>.from(json["mainLemmas"].map((x) => Main.fromJson(x))),
    // mainSyncons: List<MainSyncon>.from(json["mainSyncons"].map((x) => MainSyncon.fromJson(x))),
    // entities: List<Entity>.from(json["entities"].map((x) => Entity.fromJson(x))),
    // topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
    // knowledge: List<Knowledge>.from(json["knowledge"].map((x) => Knowledge.fromJson(x))),
    // sentiment: Sentiment.fromJson(json["sentiment"]),
    // relations: List<Relation>.from(json["relations"].map((x) => Relation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    // "version": version,
    // "content": content,
    // "language": language,
    // "paragraphs": List<dynamic>.from(paragraphs.map((x) => x.toJson())),
    // "sentences": List<dynamic>.from(sentences.map((x) => x.toJson())),
    // "phrases": List<dynamic>.from(phrases.map((x) => x.toJson())),
    // "tokens": List<dynamic>.from(tokens.map((x) => x.toJson())),
    // "mainSentences": List<dynamic>.from(mainSentences.map((x) => x.toJson())),
    "mainPhrases": List<dynamic>.from(mainPhrases.map((x) => x.toJson())),
    "mainLemmas": List<dynamic>.from(mainLemmas.map((x) => x.toJson())),
    // "mainSyncons": List<dynamic>.from(mainSyncons.map((x) => x.toJson())),
    // "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
    // "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    // "knowledge": List<dynamic>.from(knowledge.map((x) => x.toJson())),
    // "sentiment": sentiment.toJson(),
    // "relations": List<dynamic>.from(relations.map((x) => x.toJson())),
  };
}

class Entity {
  Entity({
    required this.type,
    required this.lemma,
    required this.syncon,
    required this.positions,
    required this.relevance,
    required this.attributes,
  });

  String type;
  String lemma;
  int syncon;
  List<Position> positions;
  int relevance;
  List<Attribute> attributes;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    type: json["type"],
    lemma: json["lemma"],
    syncon: json["syncon"],
    positions: List<Position>.from(json["positions"].map((x) => Position.fromJson(x))),
    relevance: json["relevance"],
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "lemma": lemma,
    "syncon": syncon,
    "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
    "relevance": relevance,
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    required this.attribute,
    required this.lemma,
    required this.syncon,
    required this.type,
    required this.attributes,
  });

  String attribute;
  String lemma;
  int syncon;
  String type;
  List<dynamic> attributes;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    attribute: json["attribute"],
    lemma: json["lemma"],
    syncon: json["syncon"],
    type: json["type"],
    attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "attribute": attribute,
    "lemma": lemma,
    "syncon": syncon,
    "type": type,
    "attributes": List<dynamic>.from(attributes.map((x) => x)),
  };
}

class Position {
  Position({
    required this.start,
    required this.end,
  });

  int start;
  int end;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
  };
}

class Knowledge {
  Knowledge({
    required this.syncon,
    required this.label,
    required this.properties,
  });

  int syncon;
  String label;
  List<Property> properties;

  factory Knowledge.fromJson(Map<String, dynamic> json) => Knowledge(
    syncon: json["syncon"],
    label: json["label"],
    properties: List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "syncon": syncon,
    "label": label,
    "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
  };
}

class Property {
  Property({
    required this.type,
    required this.value,
  });

  String type;
  String value;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

class Main {
  Main({
    required this.value,
    required this.score,
    required this.positions,
  });

  String value;
  double score;
  List<Position> positions;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    value: json["value"],
    score: json["score"],
    positions: List<Position>.from(json["positions"].map((x) => Position.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "score": score,
    "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
  };
}

class MainSentence {
  MainSentence({
    required this.value,
    required this.score,
    required this.start,
    required this.end,
  });

  String value;
  double score;
  int start;
  int end;

  factory MainSentence.fromJson(Map<String, dynamic> json) => MainSentence(
    value: json["value"],
    score: json["score"],
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "score": score,
    "start": start,
    "end": end,
  };
}

class MainSyncon {
  MainSyncon({
    required this.syncon,
    required this.lemma,
    required this.score,
    required this.positions,
  });

  int syncon;
  String lemma;
  double score;
  List<Position> positions;

  factory MainSyncon.fromJson(Map<String, dynamic> json) => MainSyncon(
    syncon: json["syncon"],
    lemma: json["lemma"],
    score: json["score"],
    positions: List<Position>.from(json["positions"].map((x) => Position.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "syncon": syncon,
    "lemma": lemma,
    "score": score,
    "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
  };
}

class Paragraph {
  Paragraph({
    required this.start,
    required this.end,
    required this.sentences,
  });

  int start;
  int end;
  List<int> sentences;

  factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
    start: json["start"],
    end: json["end"],
    sentences: List<int>.from(json["sentences"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
    "sentences": List<dynamic>.from(sentences.map((x) => x)),
  };
}

class Phrase {
  Phrase({
    required this.start,
    required this.end,
    this.tokens,
    required this.type,
    this.lemma,
  });

  int start;
  int end;
  List<int>? tokens;
  String type;
  String? lemma;

  factory Phrase.fromJson(Map<String, dynamic> json) => Phrase(
    start: json["start"],
    end: json["end"],
    tokens: json["tokens"] == null ? [] : List<int>.from(json["tokens"]!.map((x) => x)),
    type: json["type"],
    lemma: json["lemma"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
    "type": type,
    "lemma": lemma,
  };
}

class Relation {
  Relation({
    required this.verb,
    required this.related,
  });

  Verb verb;
  List<Related> related;

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
    verb: Verb.fromJson(json["verb"]),
    related: List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "verb": verb.toJson(),
    "related": List<dynamic>.from(related.map((x) => x.toJson())),
  };
}

class Related {
  Related({
    required this.relation,
    required this.text,
    required this.lemma,
    required this.syncon,
    required this.vsyn,
    required this.type,
    required this.phrase,
    required this.relevance,
    required this.related,
  });

  String relation;
  String text;
  String lemma;
  int syncon;
  Vsyn vsyn;
  String type;
  int phrase;
  int relevance;
  List<dynamic> related;

  factory Related.fromJson(Map<String, dynamic> json) => Related(
    relation: json["relation"],
    text: json["text"],
    lemma: json["lemma"],
    syncon: json["syncon"],
    vsyn: Vsyn.fromJson(json["vsyn"]),
    type: json["type"],
    phrase: json["phrase"],
    relevance: json["relevance"],
    related: List<dynamic>.from(json["related"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "relation": relation,
    "text": text,
    "lemma": lemma,
    "syncon": syncon,
    "vsyn": vsyn.toJson(),
    "type": type,
    "phrase": phrase,
    "relevance": relevance,
    "related": List<dynamic>.from(related.map((x) => x)),
  };
}

class Vsyn {
  Vsyn({
    required this.id,
    required this.parent,
  });

  int id;
  int parent;

  factory Vsyn.fromJson(Map<String, dynamic> json) => Vsyn(
    id: json["id"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent": parent,
  };
}

class Verb {
  Verb({
    required this.text,
    required this.lemma,
    required this.syncon,
    required this.type,
    required this.phrase,
    required this.relevance,
  });

  String text;
  String lemma;
  int syncon;
  String type;
  int phrase;
  int relevance;

  factory Verb.fromJson(Map<String, dynamic> json) => Verb(
    text: json["text"],
    lemma: json["lemma"],
    syncon: json["syncon"],
    type: json["type"],
    phrase: json["phrase"],
    relevance: json["relevance"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "lemma": lemma,
    "syncon": syncon,
    "type": type,
    "phrase": phrase,
    "relevance": relevance,
  };
}

class Sentence {
  Sentence({
    required this.start,
    required this.end,
    required this.phrases,
  });

  int start;
  int end;
  List<int> phrases;

  factory Sentence.fromJson(Map<String, dynamic> json) => Sentence(
    start: json["start"],
    end: json["end"],
    phrases: List<int>.from(json["phrases"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
    "phrases": List<dynamic>.from(phrases.map((x) => x)),
  };
}

class Sentiment {
  Sentiment({
    required this.overall,
    required this.negativity,
    required this.positivity,
    required this.items,
  });

  int overall;
  int negativity;
  int positivity;
  List<Item> items;

  factory Sentiment.fromJson(Map<String, dynamic> json) => Sentiment(
    overall: json["overall"],
    negativity: json["negativity"],
    positivity: json["positivity"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overall": overall,
    "negativity": negativity,
    "positivity": positivity,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.lemma,
    required this.syncon,
    required this.sentiment,
    required this.items,
  });

  String lemma;
  int syncon;
  int sentiment;
  List<dynamic> items;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    lemma: json["lemma"],
    syncon: json["syncon"],
    sentiment: json["sentiment"],
    items: List<dynamic>.from(json["items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "lemma": lemma,
    "syncon": syncon,
    "sentiment": sentiment,
    "items": List<dynamic>.from(items.map((x) => x)),
  };
}

class Token {
  Token({
    required this.start,
    required this.end,
    required this.type,
    required this.pos,
    required this.lemma,
    required this.syncon,
    // required this.vsyn,
    required this.morphology,
    required this.dependency,
    // required this.atoms,
    required this.paragraph,
    required this.sentence,
    required this.phrase,
  });

  int start;
  int end;
  String type;
  String pos;
  String lemma;
  int syncon;
  // Vsyn vsyn;
  String morphology;
  Dependency dependency;
  // List<Phrase> atoms;
  int paragraph;
  int sentence;
  int phrase;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    start: json["start"],
    end: json["end"],
    type: json["type"],
    pos: json["pos"],
    lemma: json["lemma"],
    syncon: json["syncon"],
    // vsyn: Vsyn.fromJson(json["vsyn"]),
    morphology: json["morphology"],
    dependency: Dependency.fromJson(json["dependency"]),
    // atoms: List<Phrase>.from(json["atoms"].map((x) => Phrase.fromJson(x))),
    paragraph: json["paragraph"],
    sentence: json["sentence"],
    phrase: json["phrase"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
    "type": type,
    "pos": pos,
    "lemma": lemma,
    "syncon": syncon,
    // "vsyn": vsyn.toJson(),
    "morphology": morphology,
    "dependency": dependency.toJson(),
    // "atoms": List<dynamic>.from(atoms.map((x) => x.toJson())),
    "paragraph": paragraph,
    "sentence": sentence,
    "phrase": phrase,
  };
}

class Dependency {
  Dependency({
    required this.id,
    required this.head,
    required this.label,
  });

  int id;
  int head;
  String label;

  factory Dependency.fromJson(Map<String, dynamic> json) => Dependency(
    id: json["id"],
    head: json["head"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "head": head,
    "label": label,
  };
}

class Topic {
  Topic({
    required this.id,
    required this.label,
    required this.score,
    required this.winner,
  });

  int id;
  String label;
  int score;
  bool winner;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    label: json["label"],
    score: json["score"],
    winner: json["winner"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "score": score,
    "winner": winner,
  };
}

class Error {
  Error({
    required this.code,
    required this.message,
  });

  String code;
  String message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
