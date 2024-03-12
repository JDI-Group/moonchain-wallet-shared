import 'package:mxc_logic/mxc_logic.dart';

class JSChannelScripts {
  static String axsWalletObjectInjectScript(
    String axsWalletJSObjectName,
  ) =>
      'window.$axsWalletJSObjectName = { callHandler: window.flutter_inappwebview.callHandler }';
  static String axsWalletReadyInjectScript(
    String axsReadyEvent,
  ) =>
      '''
        const event = new CustomEvent('$axsReadyEvent', {});
        window.dispatchEvent(event);
      ''';

  static String axsWalletJSHandler(
    String axsWalletJSObjectName,
    String eventName,
    Map<String, dynamic> data,
  ) =>
      'window.$axsWalletJSObjectName.callHandler(\'$eventName\', $data)';

  static String walletProviderInfoScript(
    int chainId,
    String web3RpcHttpUrl,
    String address,
  ) =>
      '''{
              ethereum: {
                chainId: $chainId,
                rpcUrl: "$web3RpcHttpUrl",
                address: "$address",
                isDebug: true,
                networkVersion: "$chainId",
                isMetaMask: true
              }
            }''';
  static const String clipboardHandlerScript =
      'javascript:navigator.clipboard.writeText = (msg) => { return window.flutter_inappwebview?.callHandler("${JSChannelEvents.axsWalletCopyClipboard}", msg); }';

  static const String overScrollScript = '''
      var pStart = { x: 0, y: 0 };
      var pStop = { x: 0, y: 0 };

      function swipeStart(e) {
        if (typeof e["targetTouches"] !== "undefined") {
          var touch = e.targetTouches[0];
          pStart.x = touch.screenX;
          pStart.y = touch.screenY;
        } else {
          pStart.x = e.screenX;
          pStart.y = e.screenY;
        }
      }

      function swipeEnd(e) {
        if (typeof e["changedTouches"] !== "undefined") {
          var touch = e.changedTouches[0];
          pStop.x = touch.screenX;
          pStop.y = touch.screenY;
        } else {
          pStop.x = e.screenX;
          pStop.y = e.screenY;
        }

        swipeCheck();
      }

      function swipeCheck() {
        var changeY = pStart.y - pStop.y;
        var changeX = pStart.x - pStop.x;
        if (isPullDown(changeY, changeX)) {
          window.flutter_inappwebview?.callHandler("${JSChannelEvents.axsWalletScrollDetector}", true);
        } else if (isPullUp(changeY, changeX)) {
          window.flutter_inappwebview?.callHandler("${JSChannelEvents.axsWalletScrollDetector}", false);
        }
      }

      function isPullDown(dY, dX) {
        // methods of checking slope, length, direction of line created by swipe action
        console.log(dY);
        console.log(dX );
        return (
          dY < 0 &&
          ((Math.abs(dX) <= 100 && Math.abs(dY) >= 100 ) ||
            (Math.abs(dX) / Math.abs(dY) <= 0.1 && dY >= 60))
        );
      }

      function isPullUp(dY, dX) {
        // Check if the gesture is a pull-up
        console.log(dY);
        console.log(dX);
        return (
          dY > 0 &&
          ((Math.abs(dX) <= 100 && Math.abs(dY) >= 100) ||
            (Math.abs(dX) / Math.abs(dY) <= 0.1 && dY >= 60))
        );
      }

      document.addEventListener(
        "touchstart",
        function (e) {
          swipeStart(e);
        },
        false
      );
      document.addEventListener(
        "touchend",
        function (e) {
          swipeEnd(e);
        },
        false
      );
      ''';
}
