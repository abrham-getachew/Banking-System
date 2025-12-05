import 'dart:math';
import '../models/nft_model.dart';

class NFTService {
  // Mock NFT data - in production, use OpenSea API or similar
  static const List<Map<String, dynamic>> _mockNFTData = [
    {
      'id': 'nft_1',
      'name': 'Cyber Punk #1234',
      'description': 'A unique cyberpunk character with rare traits',
      'image_url':
          'https://images.unsplash.com/photo-1635322966219-b75ed372eb01?w=400',
      'collection_name': 'CyberPunks',
      'creator': 'ArtistDAO',
      'price': 2.5,
      'currency': 'ETH',
      'traits': ['Rare', 'Animated', 'Limited Edition'],
      'blockchain': 'Ethereum',
    },
    {
      'id': 'nft_2',
      'name': 'Abstract Dreams #567',
      'description': 'A beautiful abstract artwork with vibrant colors',
      'image_url':
          'https://images.unsplash.com/photo-1634986666676-ec8fd927c23d?w=400',
      'collection_name': 'Abstract Dreams',
      'creator': 'DigitalArtist',
      'price': 1.8,
      'currency': 'ETH',
      'traits': ['Abstract', 'Colorful', 'Modern'],
      'blockchain': 'Ethereum',
    },
    {
      'id': 'nft_3',
      'name': 'Space Explorer #890',
      'description': 'An astronaut exploring the vast cosmos',
      'image_url':
          'https://images.unsplash.com/photo-1614728263952-84ea256f9679?w=400',
      'collection_name': 'Space Explorers',
      'creator': 'CosmosCreator',
      'price': 3.2,
      'currency': 'ETH',
      'traits': ['Space', 'Adventure', 'Rare'],
      'blockchain': 'Ethereum',
    },
    {
      'id': 'nft_4',
      'name': 'Digital Landscape #345',
      'description': 'A serene digital landscape with mountains and lakes',
      'image_url':
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400',
      'collection_name': 'Digital Landscapes',
      'creator': 'NatureArtist',
      'price': 1.5,
      'currency': 'ETH',
      'traits': ['Nature', 'Peaceful', 'Scenic'],
      'blockchain': 'Ethereum',
    },
    {
      'id': 'nft_5',
      'name': 'Geometric Patterns #678',
      'description': 'Complex geometric patterns with mathematical precision',
      'image_url':
          'https://images.unsplash.com/photo-1621641788421-7a480a2b10cb?w=400',
      'collection_name': 'Geometric Art',
      'creator': 'MathArtist',
      'price': 2.1,
      'currency': 'ETH',
      'traits': ['Geometric', 'Mathematical', 'Precise'],
      'blockchain': 'Ethereum',
    },
  ];

  Future<List<NFTModel>> getFeaturedNFTs() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      final random = Random();
      final nfts = <NFTModel>[];

      for (final data in _mockNFTData) {
        // Add some price variation
        final priceVariation =
            (random.nextDouble() - 0.5) * 0.1; // ±5% variation
        final price = data['price'].toDouble() * (1 + priceVariation);

        final nft = NFTModel(
          id: data['id'],
          name: data['name'],
          description: data['description'],
          imageUrl: data['image_url'],
          collectionName: data['collection_name'],
          creator: data['creator'],
          owner: 'Owner${random.nextInt(1000)}',
          price: price,
          currency: data['currency'],
          traits: List<String>.from(data['traits']),
          blockchain: data['blockchain'],
          tokenId: 'token_${random.nextInt(10000)}',
          contractAddress:
              '0x${random.nextInt(999999).toString().padLeft(6, '0')}',
          createdAt:
              DateTime.now().subtract(Duration(days: random.nextInt(365))),
          lastSold: random.nextBool()
              ? DateTime.now().subtract(Duration(days: random.nextInt(30)))
              : null,
          isForSale: random.nextBool(),
        );

        nfts.add(nft);
      }

      return nfts;
    } catch (e) {
      throw Exception('Failed to fetch featured NFTs: ${e.toString()}');
    }
  }

  Future<List<NFTModel>> searchNFTs(String query) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      final allNFTs = await getFeaturedNFTs();

      if (query.isEmpty) {
        return allNFTs;
      }

      return allNFTs.where((nft) {
        return nft.name.toLowerCase().contains(query.toLowerCase()) ||
            nft.collectionName.toLowerCase().contains(query.toLowerCase()) ||
            nft.creator.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } catch (e) {
      throw Exception('Failed to search NFTs: ${e.toString()}');
    }
  }

  Future<List<NFTModel>> getNFTsByCollection(String collectionName) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final allNFTs = await getFeaturedNFTs();

      return allNFTs
          .where((nft) =>
              nft.collectionName.toLowerCase() == collectionName.toLowerCase())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch collection NFTs: ${e.toString()}');
    }
  }

  Future<NFTModel> getNFTById(String nftId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      final data = _mockNFTData.firstWhere(
        (nft) => nft['id'] == nftId,
        orElse: () => _mockNFTData.first,
      );

      final random = Random();
      final priceVariation = (random.nextDouble() - 0.5) * 0.1;
      final price = data['price'].toDouble() * (1 + priceVariation);

      return NFTModel(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        imageUrl: data['image_url'],
        collectionName: data['collection_name'],
        creator: data['creator'],
        owner: 'Owner${random.nextInt(1000)}',
        price: price,
        currency: data['currency'],
        traits: List<String>.from(data['traits']),
        blockchain: data['blockchain'],
        tokenId: 'token_${random.nextInt(10000)}',
        contractAddress:
            '0x${random.nextInt(999999).toString().padLeft(6, '0')}',
        createdAt: DateTime.now().subtract(Duration(days: random.nextInt(365))),
        lastSold: random.nextBool()
            ? DateTime.now().subtract(Duration(days: random.nextInt(30)))
            : null,
        isForSale: true,
      );
    } catch (e) {
      throw Exception('Failed to fetch NFT: ${e.toString()}');
    }
  }

  Future<List<NFTModel>> getUserNFTs(String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 700));

      final random = Random();
      final userNFTs = <NFTModel>[];

      // Generate random user NFTs
      for (int i = 0; i < 3; i++) {
        final data = _mockNFTData[random.nextInt(_mockNFTData.length)];

        final nft = NFTModel(
          id: '${data['id']}_owned_$i',
          name: data['name'],
          description: data['description'],
          imageUrl: data['image_url'],
          collectionName: data['collection_name'],
          creator: data['creator'],
          owner: userId,
          price: data['price'].toDouble(),
          currency: data['currency'],
          traits: List<String>.from(data['traits']),
          blockchain: data['blockchain'],
          tokenId: 'token_${random.nextInt(10000)}',
          contractAddress:
              '0x${random.nextInt(999999).toString().padLeft(6, '0')}',
          createdAt:
              DateTime.now().subtract(Duration(days: random.nextInt(365))),
          lastSold: DateTime.now().subtract(Duration(days: random.nextInt(30))),
          isForSale: random.nextBool(),
        );

        userNFTs.add(nft);
      }

      return userNFTs;
    } catch (e) {
      throw Exception('Failed to fetch user NFTs: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> purchaseNFT({
    required String userId,
    required String nftId,
    required double price,
    required String currency,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1200));

      return {
        'transactionId':
            'nft_purchase_${DateTime.now().millisecondsSinceEpoch}',
        'nftId': nftId,
        'buyerId': userId,
        'price': price,
        'currency': currency,
        'status': 'completed',
        'timestamp': DateTime.now().toIso8601String(),
        'gasFee': 0.02, // Mock gas fee
      };
    } catch (e) {
      throw Exception('Failed to purchase NFT: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> listNFTForSale({
    required String userId,
    required String nftId,
    required double price,
    required String currency,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      return {
        'listingId': 'nft_listing_${DateTime.now().millisecondsSinceEpoch}',
        'nftId': nftId,
        'sellerId': userId,
        'price': price,
        'currency': currency,
        'status': 'active',
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception('Failed to list NFT for sale: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getFeaturedCollections() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final collections = [
        {
          'name': 'CyberPunks',
          'description': 'A collection of unique cyberpunk characters',
          'imageUrl':
              'https://images.unsplash.com/photo-1635322966219-b75ed372eb01?w=400',
          'floorPrice': 1.5,
          'volume': 245.8,
          'items': 10000,
        },
        {
          'name': 'Abstract Dreams',
          'description': 'Beautiful abstract artworks',
          'imageUrl':
              'https://images.unsplash.com/photo-1634986666676-ec8fd927c23d?w=400',
          'floorPrice': 0.8,
          'volume': 156.3,
          'items': 5000,
        },
        {
          'name': 'Space Explorers',
          'description': 'Astronauts exploring the cosmos',
          'imageUrl':
              'https://images.unsplash.com/photo-1614728263952-84ea256f9679?w=400',
          'floorPrice': 2.1,
          'volume': 389.2,
          'items': 8000,
        },
      ];

      return collections;
    } catch (e) {
      throw Exception('Failed to fetch featured collections: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getNFTMarketStats() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      final random = Random();

      return {
        'totalVolume': 15420.5 + random.nextDouble() * 1000,
        'totalSales': 125486,
        'averagePrice': 2.34 + random.nextDouble() * 0.5,
        'activeListings': 45892,
        'topCollections': [
          {'name': 'CyberPunks', 'volume': 245.8},
          {'name': 'Space Explorers', 'volume': 389.2},
          {'name': 'Abstract Dreams', 'volume': 156.3},
        ],
      };
    } catch (e) {
      throw Exception('Failed to fetch NFT market stats: ${e.toString()}');
    }
  }
}
