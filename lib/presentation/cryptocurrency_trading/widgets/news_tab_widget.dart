import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NewsTabWidget extends StatelessWidget {
  final List<Map<String, dynamic>> newsData;

  const NewsTabWidget({
    Key? key,
    required this.newsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Simulate refresh
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.separated(
        padding: EdgeInsets.all(4.w),
        itemCount: newsData.length,
        separatorBuilder: (context, index) => SizedBox(height: 3.h),
        itemBuilder: (context, index) {
          final news = newsData[index];
          return _buildNewsCard(context, news);
        },
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, Map<String, dynamic> news) {
    final publishedAt = news["publishedAt"] as DateTime;
    final timeAgo = _getTimeAgo(publishedAt);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: CustomImageWidget(
              imageUrl: news["imageUrl"] as String,
              width: double.infinity,
              height: 25.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: AppTheme.accentGold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        news["source"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.accentGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      timeAgo,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  news["title"] as String,
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                Text(
                  news["summary"] as String,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => _openArticle(context, news),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.accentGold,
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Read Full Article'),
                            SizedBox(width: 2.w),
                            CustomIconWidget(
                              iconName: 'arrow_forward',
                              color: AppTheme.accentGold,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    IconButton(
                      onPressed: () => _shareArticle(context, news),
                      icon: CustomIconWidget(
                        iconName: 'share',
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _bookmarkArticle(context, news),
                      icon: CustomIconWidget(
                        iconName: 'bookmark_border',
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime publishedAt) {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _openArticle(BuildContext context, Map<String, dynamic> news) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Open Article'),
        content: Text('Opening article: ${news["title"]}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // In a real app, this would open the URL in a web view or browser
            },
            child: Text('Open'),
          ),
        ],
      ),
    );
  }

  void _shareArticle(BuildContext context, Map<String, dynamic> news) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Article shared: ${news["title"]}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _bookmarkArticle(BuildContext context, Map<String, dynamic> news) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Article bookmarked: ${news["title"]}'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
