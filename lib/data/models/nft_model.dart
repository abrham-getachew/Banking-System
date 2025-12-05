class NFTModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String collectionName;
  final String creator;
  final String owner;
  final double price;
  final String currency;
  final List<String> traits;
  final String blockchain;
  final String tokenId;
  final String contractAddress;
  final DateTime createdAt;
  final DateTime? lastSold;
  final bool isForSale;

  NFTModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.collectionName,
    required this.creator,
    required this.owner,
    required this.price,
    required this.currency,
    required this.traits,
    required this.blockchain,
    required this.tokenId,
    required this.contractAddress,
    required this.createdAt,
    this.lastSold,
    required this.isForSale,
  });

  factory NFTModel.fromJson(Map<String, dynamic> json) {
    return NFTModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      collectionName: json['collection_name'],
      creator: json['creator'],
      owner: json['owner'],
      price: json['price'].toDouble(),
      currency: json['currency'],
      traits: List<String>.from(json['traits'] ?? []),
      blockchain: json['blockchain'],
      tokenId: json['token_id'],
      contractAddress: json['contract_address'],
      createdAt: DateTime.parse(json['created_at']),
      lastSold:
          json['last_sold'] != null ? DateTime.parse(json['last_sold']) : null,
      isForSale: json['is_for_sale'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'collection_name': collectionName,
      'creator': creator,
      'owner': owner,
      'price': price,
      'currency': currency,
      'traits': traits,
      'blockchain': blockchain,
      'token_id': tokenId,
      'contract_address': contractAddress,
      'created_at': createdAt.toIso8601String(),
      'last_sold': lastSold?.toIso8601String(),
      'is_for_sale': isForSale,
    };
  }
}
