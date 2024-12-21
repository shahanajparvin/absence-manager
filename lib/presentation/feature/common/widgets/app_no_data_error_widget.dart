import 'package:absence_manager/core/utils/app_color.dart';
import 'package:absence_manager/core/utils/app_size.dart';
import 'package:absence_manager/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppNoDataErrorWidget extends StatelessWidget {
  final String? description;
  final bool isReTry;
  final VoidCallback? onRetryCallBack;
  final bool isError;
  final String? retryLabel;

  const AppNoDataErrorWidget(
      {super.key,
      this.description,
      this.isReTry = false,
      this.onRetryCallBack,
      this.isError = false,
      this.retryLabel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment : MainAxisAlignment.center,
              mainAxisSize : MainAxisSize.min,
              children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.string(
                        isError?errorIllistration:noResultIllistration,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                InfoWidget(
                  description: description != null
                          ? description!
                          : context.text.general_error_message,
                  btnText: retryLabel ?? context.text.retry,
                  press: onRetryCallBack,
                  isReTry: isReTry,
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.description,
    this.btnText,
    this.press,
    required this.isReTry,
  });
  final String? description;
  final String? btnText;
  final VoidCallback? press;
  final bool isReTry;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize : MainAxisSize.min,
        children: [
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium!
                  .copyWith(color: AppColor.textColorDark,fontWeight: FontWeight.w400,fontSize: AppTextSize.s14),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

const errorIllistration =
    '''<svg width="1080" height="1080" viewBox="0 0 1080 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M378 809C154.5 782.5 232.5 494.5 421.5 546.5C446.5 275.5 820.5 310.5 805.5 576.5C954.5 538.5 1029.5 763.5 851 807L378 809Z" fill="#DDDDDD"/>
<path d="M316.5 784C293.933 783.993 271.726 778.35 251.893 767.584C232.061 756.817 215.231 741.268 202.933 722.347C190.634 703.426 183.256 681.734 181.467 659.238C179.679 636.742 183.537 614.156 192.692 593.53C201.847 572.904 216.008 554.891 233.891 541.126C251.773 527.361 272.81 518.281 295.092 514.708C317.374 511.136 340.196 513.186 361.485 520.671C382.774 528.156 401.856 540.839 417 557.57" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M360.5 520.5C360.5 413.91 446.91 332.5 553.5 332.5C660.09 332.5 746.5 418.91 746.5 525.5C746.521 545.524 743.424 565.429 737.32 584.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M744.87 550.63C761.164 546.201 778.217 545.304 794.886 548.001C811.555 550.698 827.455 556.926 841.521 566.268C855.587 575.61 867.495 587.849 876.446 602.167C885.397 616.485 891.185 632.551 893.422 649.287C895.66 666.024 894.295 683.046 889.419 699.212C884.543 715.378 876.268 730.316 865.15 743.024C854.031 755.733 840.325 765.918 824.95 772.899C809.575 779.879 792.886 783.494 776 783.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M316.5 783.5H776.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M458 656.5C482.577 656.5 502.5 636.577 502.5 612C502.5 587.423 482.577 567.5 458 567.5C433.423 567.5 413.5 587.423 413.5 612C413.5 636.577 433.423 656.5 458 656.5Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M458 645.5C476.502 645.5 491.5 630.502 491.5 612C491.5 593.498 476.502 578.5 458 578.5C439.498 578.5 424.5 593.498 424.5 612C424.5 630.502 439.498 645.5 458 645.5Z" fill="#0E0E0E"/>
<path d="M477 599C479.209 599 481 597.209 481 595C481 592.791 479.209 591 477 591C474.791 591 473 592.791 473 595C473 597.209 474.791 599 477 599Z" fill="white"/>
<path d="M470 608C471.105 608 472 607.105 472 606C472 604.895 471.105 604 470 604C468.895 604 468 604.895 468 606C468 607.105 468.895 608 470 608Z" fill="white"/>
<path d="M632 656.5C656.577 656.5 676.5 636.577 676.5 612C676.5 587.423 656.577 567.5 632 567.5C607.423 567.5 587.5 587.423 587.5 612C587.5 636.577 607.423 656.5 632 656.5Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M632 645.5C650.502 645.5 665.5 630.502 665.5 612C665.5 593.498 650.502 578.5 632 578.5C613.498 578.5 598.5 593.498 598.5 612C598.5 630.502 613.498 645.5 632 645.5Z" fill="#0E0E0E"/>
<path d="M651 599C653.209 599 655 597.209 655 595C655 592.791 653.209 591 651 591C648.791 591 647 592.791 647 595C647 597.209 648.791 599 651 599Z" fill="white"/>
<path d="M644 608C645.105 608 646 607.105 646 606C646 604.895 645.105 604 644 604C642.895 604 642 604.895 642 606C642 607.105 642.895 608 644 608Z" fill="white"/>
<path d="M507 708C542.17 687.32 570.45 694.36 595 708" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M553.01 893.96C596.646 893.96 632.02 858.586 632.02 814.95C632.02 771.314 596.646 735.94 553.01 735.94C509.374 735.94 474 771.314 474 814.95C474 858.586 509.374 893.96 553.01 893.96Z" fill="#BCBCBC"/>
<path d="M554.72 893.69C598.356 893.69 633.73 858.316 633.73 814.68C633.73 771.044 598.356 735.67 554.72 735.67C511.084 735.67 475.71 771.044 475.71 814.68C475.71 858.316 511.084 893.69 554.72 893.69Z" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M554.74 854.17V793.7" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M535.59 812.09L554.24 786.27L573.6 812.09" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M260.46 479.5C304.643 479.5 340.46 443.683 340.46 399.5C340.46 355.317 304.643 319.5 260.46 319.5C216.277 319.5 180.46 355.317 180.46 399.5C180.46 443.683 216.277 479.5 260.46 479.5Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M798 213.5C809.874 213.5 819.5 203.874 819.5 192C819.5 180.126 809.874 170.5 798 170.5C786.126 170.5 776.5 180.126 776.5 192C776.5 203.874 786.126 213.5 798 213.5Z" fill="#BCBCBC"/>
<path d="M806 265C810.418 265 814 261.418 814 257C814 252.582 810.418 249 806 249C801.582 249 798 252.582 798 257C798 261.418 801.582 265 806 265Z" fill="#BCBCBC"/>
<path d="M734.5 242C745.27 242 754 233.27 754 222.5C754 211.73 745.27 203 734.5 203C723.73 203 715 211.73 715 222.5C715 233.27 723.73 242 734.5 242Z" fill="#BCBCBC"/>
<path d="M146 873C150.971 873 155 868.971 155 864C155 859.029 150.971 855 146 855C141.029 855 137 859.029 137 864C137 868.971 141.029 873 146 873Z" fill="#BCBCBC"/>
<path d="M216.5 899C226.165 899 234 891.165 234 881.5C234 871.835 226.165 864 216.5 864C206.835 864 199 871.835 199 881.5C199 891.165 206.835 899 216.5 899Z" fill="#BCBCBC"/>
<path d="M174 955C189.464 955 202 942.464 202 927C202 911.536 189.464 899 174 899C158.536 899 146 911.536 146 927C146 942.464 158.536 955 174 955Z" fill="#BCBCBC"/>
<path d="M776 145L754 123" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M806 143L814 113" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M831.5 153.5L844.5 148.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M202.5 859.5L192.5 842.5" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M222.5 854.5L233.5 837.5" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M165.5 340.5L106.5 319.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M223.5 301.5L194.85 212.37" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M307.5 307.5L331.5 254.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M293 369L227 435" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M227 369L293 435" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

const noResultIllistration = '''
<svg width="192" height="169" viewBox="0 0 192 169" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M95.6313 132.935C96.509 132.935 97.2205 132.224 97.2205 131.346C97.2205 130.469 96.509 129.757 95.6313 129.757C94.7535 129.757 94.042 130.469 94.042 131.346C94.042 132.224 94.7535 132.935 95.6313 132.935Z" fill="#CFCFCF"/>
<path d="M49.459 13.2803V20.254" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M45.9551 16.7666H52.945" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M128.845 57.2622C115.271 57.2622 101.453 56.7108 88.5276 53.1103C75.8451 49.591 64.2009 42.7634 53.8213 34.8652C47.0261 29.7242 40.8471 25.6209 32.0245 26.2372C23.3934 26.7043 15.1398 29.9271 8.47606 35.4327C-2.74683 45.2606 -1.05992 63.4734 3.43241 76.2206C10.1791 95.4713 30.711 108.883 48.1613 117.56C68.3201 127.631 90.4738 133.486 112.676 136.843C132.138 139.811 157.145 141.952 174.012 129.253C189.5 117.56 193.749 90.8976 189.954 72.8959C189.033 67.578 186.202 62.7793 181.991 59.4028C171.109 51.4399 154.875 56.7593 142.647 57.0187C138.106 57.1163 133.484 57.2298 128.845 57.2622Z" fill="#F2F2F2"/>
<path d="M106.887 3.77621C107.765 3.77621 108.476 3.06471 108.476 2.18693C108.476 1.30915 107.765 0.597656 106.887 0.597656C106.009 0.597656 105.298 1.30915 105.298 2.18693C105.298 3.06471 106.009 3.77621 106.887 3.77621Z" fill="#CFCFCF"/>
<path d="M24.3037 127.532V134.506" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M20.8174 131.023H27.7911" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M96.279 168.403C129.159 168.403 155.815 166.74 155.815 164.689C155.815 162.637 129.159 160.975 96.279 160.975C63.3981 160.975 36.7432 162.637 36.7432 164.689C36.7432 166.74 63.3981 168.403 96.279 168.403Z" fill="#F2F2F2"/>
<path d="M144.14 124.908H41.3022C40.6142 124.908 39.9341 124.757 39.3096 124.469C38.685 124.18 38.1306 123.758 37.6849 123.234C37.2391 122.709 36.9127 122.094 36.7281 121.431C36.5435 120.768 36.5048 120.073 36.6152 119.394L49.7679 39.6345C49.9457 38.5245 50.5138 37.514 51.3699 36.7858C52.2264 36.0572 53.3144 35.6584 54.4387 35.6611H157.276C157.964 35.6611 158.643 35.811 159.268 36.1002C159.891 36.3894 160.445 36.8111 160.89 37.3359C161.334 37.8606 161.659 38.4757 161.842 39.1387C162.023 39.802 162.061 40.4967 161.947 41.175L148.86 120.935C148.678 122.052 148.102 123.066 147.236 123.795C146.37 124.523 145.272 124.919 144.14 124.908Z" fill="#D2D2D2"/>
<path d="M145.405 33.5741L84.3632 6.31965C82.5637 5.51632 80.4539 6.32362 79.6506 8.12311L60.304 51.4538C59.5007 53.2532 60.308 55.363 62.1072 56.1664L123.149 83.4206C124.949 84.2239 127.059 83.4166 127.862 81.6174L147.208 38.2868C148.013 36.4873 147.205 34.3775 145.405 33.5741Z" fill="white" stroke="#BABABA" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M93.3115 41.9696C94.9182 39.7149 97.255 38.0853 99.9258 37.3568C102.597 36.6282 105.437 36.8451 107.967 37.9712C110.496 39.0974 112.557 41.0635 113.803 43.536C115.049 46.0085 115.401 48.8356 114.8 51.5382" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M122.504 39.5196C123.427 39.5196 124.175 38.7715 124.175 37.8491C124.175 36.9265 123.427 36.1787 122.504 36.1787C121.582 36.1787 120.834 36.9265 120.834 37.8491C120.834 38.7718 121.582 39.5196 122.504 39.5196Z" fill="#BABABA"/>
<path d="M98.3062 28.7168C99.2285 28.7168 99.9766 27.969 99.9766 27.0464C99.9766 26.1241 99.2285 25.376 98.3062 25.376C97.3835 25.376 96.6357 26.1241 96.6357 27.0464C96.6357 27.969 97.3835 28.7168 98.3062 28.7168Z" fill="#BABABA"/>
<path d="M143.686 124.875H40.3452C39.0879 124.87 37.8834 124.367 36.9958 123.477C36.108 122.587 35.6097 121.38 35.6097 120.123V47.2561C35.5948 46.6239 35.7058 45.9951 35.9368 45.4066C36.1678 44.8177 36.5141 44.2813 36.9552 43.828C37.3961 43.3749 37.9233 43.0143 38.5055 42.7674C39.0876 42.5206 39.7131 42.3925 40.3455 42.3906H77.9872C78.8607 42.394 79.7163 42.6378 80.4604 43.0954C81.2042 43.5534 81.8077 44.2072 82.2041 44.9855L87.572 55.4948C87.9671 56.2743 88.57 56.9294 89.3145 57.387C90.0586 57.845 90.915 58.0881 91.7888 58.0897H143.686C144.941 58.0897 146.146 58.5885 147.035 59.4767C147.922 60.3648 148.421 61.5694 148.421 62.8255V120.123C148.421 121.38 147.923 122.586 147.035 123.477C146.147 124.367 144.942 124.87 143.686 124.875Z" fill="white" stroke="#BABABA" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M127.776 60.5713C121.806 60.5679 115.969 62.3354 111.003 65.65C106.038 68.9644 102.167 73.677 99.8802 79.1917C97.5935 84.7064 96.9933 90.7752 98.1561 96.631C99.3188 102.487 102.192 107.866 106.412 112.089C110.633 116.311 116.01 119.188 121.866 120.354C127.721 121.52 133.789 120.923 139.305 118.639C144.822 116.355 149.537 112.486 152.853 107.523C156.17 102.559 157.941 96.7232 157.941 90.7532C157.941 82.7513 154.764 75.0771 149.107 69.4174C143.45 63.7572 135.778 60.5756 127.776 60.5713Z" fill="white" stroke="#BABABA" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M149.247 112.646L157.291 120.69" stroke="#BABABA" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M156.382 116.785L153.884 119.399C152.764 120.572 152.806 122.429 153.977 123.549L175.665 144.282C176.836 145.403 178.694 145.361 179.815 144.188L182.314 141.574C183.435 140.403 183.392 138.545 182.22 137.424L160.533 116.692C159.361 115.571 157.502 115.613 156.382 116.785Z" fill="#D2D2D2"/>
<path d="M172.438 2.18848V9.17837" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M168.938 5.69043H175.927" stroke="#BABABA" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';


