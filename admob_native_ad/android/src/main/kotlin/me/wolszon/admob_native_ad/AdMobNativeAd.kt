class AdMobNativeAd(val context: Context, val messenger: BinaryMessenger, val id: Int) : PlatformView, MethodCallHandler {
    private var methodChannel: MethodChannel = MethodChannel(messenger, "plugins.felix.angelov/textview_$id")

    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return null;
    }

    @Override
    public onMethodCall(methodCall: MethodCall, result: MethodChannel.Result): void = when (methodCall.method) {
        "setText" -> {
//                setText(methodCall, result);
        }
        else -> result.notImplemented();
    }

    class Factory(val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
        override fun create(context: Context, id: Int, o: Object): PlatformView {
            return AdMobNativeAd(context, messenger, id);
        }
    }
}