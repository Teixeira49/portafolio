part of '../page/contact_modal.dart';

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.assetIcon,
    required this.label,
    required this.onTapRoute,
  });

  final String assetIcon;
  final String label;
  final String onTapRoute;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorValues.utilityGray100(context),
      borderRadius: BorderRadius.all(Radius.circular(WidthValues.radiusSm)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        hoverColor: ColorValues.bgBrandPrimary(context),
        hoverDuration: const Duration(milliseconds: 250),
        onTap: () => launchUrl(Uri.parse(onTapRoute)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: WidthValues.padding,
            vertical: WidthValues.spacingSm,
          ),
          width: 120,
          child: Column(
            spacing: WidthValues.padding,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(assetIcon, fit: BoxFit.contain, height: 64,),
              Text(
                label,
                style: ExtendedTextTheme.textSmall(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
