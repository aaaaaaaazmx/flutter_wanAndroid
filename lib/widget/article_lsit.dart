import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttet_demo/dao/home_dao.dart';
import 'package:fluttet_demo/model/home_ar_model_entity.dart';
import 'package:fluttet_demo/util/screen_adapter_help.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_text_styles.dart';

/// 文章列表
class ArticleLsit extends StatelessWidget {
  final List<HomeArModelDatas>? articleList;

  const ArticleLsit({super.key, this.articleList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articleList?.length ?? 0,
      itemBuilder: (ct, index) {
        return ArticleItemWidget(data: articleList![index]);
      },
    );
  }
}

/// 单个文章 item，持有点赞状态
class ArticleItemWidget extends StatefulWidget {
  final HomeArModelDatas data;

  const ArticleItemWidget({super.key, required this.data});

  @override
  State<ArticleItemWidget> createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleLike() async {
    var response;
    if (_isLiked) {
      response = await HomeDao.getUnLikeList(position: widget.data.id);
    } else {
      response = await HomeDao.getLikeList(position: widget.data.id);
    }
    if(response["errorCode"] == 0) {
      setState(() => _isLiked = !_isLiked);
      _animController.forward(from: 0);
      debugPrint("点赞：$_isLiked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.px),
      padding: EdgeInsets.all(10.px),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // 点赞按钮
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: _toggleLike,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Icon(
                  _isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  color: _isLiked ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.fromLTRB(20.px, 0, 20.px, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Text(
                            widget.data.title ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyles.inputHint,
                          ),
                          onTap: () async {
                            Uri url = Uri.parse(widget.data.link ?? "");
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                        ),
                        Padding(padding: EdgeInsetsGeometry.only(top: 10.px)),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 1.px,
                              ),
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              widget.data.superChapterName ?? "",
                              style: AppTextStyles.tagLabel,
                            ),
                          ),
                          onTap: () {
                            debugPrint("点击了标签");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: Icon(Icons.arrow_circle_up_sharp)),
        ],
      ),
    );
  }
}
