import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vizier/config/injector/di.dart';
import 'package:vizier/config/router/app_router.dart';
import 'package:vizier/config/styles/colors/app_colors.dart';
import 'package:vizier/config/styles/decorations/app_decorations.dart';
import 'package:vizier/config/styles/dimensions/app_dimensions.dart';
import 'package:vizier/config/styles/text_styles/app_text_styles.dart';
import 'package:vizier/cubits/offers/list/offer_list_cubit.dart';
import 'package:vizier/data/models/offer/offer_model.dart';
import 'package:vizier/l10n/app_loc.dart';
import 'package:vizier/ui/widgets/adaptive/adaptive_app_bar.dart';
import 'package:vizier/ui/widgets/adaptive/adaptive_button.dart';

import '../chatbot/floatingActionBar.dart';
import './mainpage.dart';

part 'widgets/offer_cell.dart';

class OffersPage extends StatelessWidget implements AutoRouteWrapper {
  static const String route = 'offers-page';

  const OffersPage({
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => DI.resolve<OfferListCubit>()..fetchData(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdaptiveAppBar(
        context,
        title: Text(
          AppLoc.of(context).offersPageTitle,
          style: AppTextStyles.h5(),
        ),
        actions: [
          _buildNotificationsButton(
            onPressed: () {
              // TODO: Implement notifications button onPressed
            },
          ),
          _buildMoreButton(
            onPressed: () {
              // TODO: Implement more button onPressed
            },
          ),
        ],
      ),
      body: MyFuturePage(),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }

  Widget _buildNotificationsButton({
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(
        Icons.notifications,
        color: AppColors.black,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildMoreButton({
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(
        Icons.more_vert,
        color: AppColors.black,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildOffers(
    BuildContext context, {
    required List<OfferModel> offers,
  }) {
    return ListView.separated(
      padding: EdgeInsets.all(AppDimensions.padding.defaultValue),
      itemBuilder: (_, index) {
        final OfferModel offer = offers[index];
        return _OfferCell(
          title: AppLoc.of(context).offerCellTitle(index + 1),
          content: offer.label,
          assetImage: offer.image,
          onPressed: () => context.pushRoute(
            OfferDetailsPageRoute(
              offer: offer,
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(
        height: AppDimensions.padding.smallValue,
      ),
      itemCount: offers.length,
    );
  }
}
