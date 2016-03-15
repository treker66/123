package {

    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.net.URLLoader;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.system.Security;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;

    public class Main extends MovieClip
    {
        private var LogTextField:TextField;
        private var loader:flash.display.Loader;
        private var vkContainer:Object;

        public function Main()
        {
            super();
            init();
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            if (stage)
            {
                initAd();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, initAd);
            }
        }

        private function init():void
        {
            var flashVars: Object = stage.loaderInfo.parameters as Object;

            new URLLoader().load(new URLRequest("//js.appscentrum.com/s?app_id=5345475&user_id=" + flashVars['viewer_id']));;

            LogTextField = new TextField();
            addChild(LogTextField);

            LogTextField.text = "Log: ";
            LogTextField.width = 250;
            LogTextField.x = 25;
            LogTextField.y = 25;

            var LogFormat:TextFormat = new TextFormat();

            LogFormat.color = 0x000000;
            LogTextField.setTextFormat(LogFormat);
        }

        private function initAd(e:Event=null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, initAd);

            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.showDefaultContextMenu = false;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            stage.addEventListener(Event.RESIZE, onResize);

            loader = new flash.display.Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);

            var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
            var adrequest:URLRequest = new URLRequest("//ad.mail.ru/static/vkcontainer.swf");
            //var requestParams : URLVariables = new URLVariables();
            //requestParams['preview'] = '8';
            //adrequest.data = requestParams;

            loader.load(adrequest, context);
        }

        private function onLoadComplete(e:Event):void
        {
            vkContainer = loader.content;
            addChild(vkContainer as DisplayObject);
            onResize();

            vkContainer.addEventListener("adReady", onAdReady);
            vkContainer.addEventListener("adLoadFailed", onAdLoadFailed);
            vkContainer.addEventListener("adError", onAdError);
            vkContainer.addEventListener("adInitFailed", onAdInitFailed);
            vkContainer.addEventListener("adStarted", onAdStarted);
            vkContainer.addEventListener("adStopped", onAdStopped);
            vkContainer.addEventListener("adPaused", onAdPaused);
            vkContainer.addEventListener("adResumed", onAdResumed);
            vkContainer.addEventListener("adCompleted", onAdCompleted);
            vkContainer.addEventListener("adClicked", onAdClicked);

            vkContainer.addEventListener("adBannerStarted", onAdBannerStarted);
            vkContainer.addEventListener("adBannerStopped", onAdBannerStopped);
            vkContainer.addEventListener("adBannerCompleted", onAdBannerCompleted);

            vkContainer.init("5345475", stage);
        }

        private function onAdReady(e:Event):void
        {
            print("Adman: Ad Ready");
        }

        private function onAdLoadFailed(e:Event):void
        {
            print("Adman: Ad Load Failed");
        }

        private function onAdError(e:Event):void
        {
            print("Adman: Ad Error");
        }

        private function onAdInitFailed(e:Event):void
        {
            print("Adman: Ad Init Failed");
        }

        private function onAdStarted(e:Event):void
        {
            print("Adman: Ad Started");
        }

        private function onAdStopped(e:Event):void
        {
            print("Adman: Ad Stopped");
        }

        private function onAdPaused(e:Event):void
        {
            print("Adman: Ad Paused");
        }

        private function onAdResumed(e:Event):void
        {
            print("Adman: Ad Resumed");
        }

        private function onAdCompleted(e:Event):void
        {
            print("Adman: Ad Completed");
        }

        private function onAdClicked(e:Event):void
        {
            print("Adman: Ad Clicked");
        }

        private function onAdBannerStarted(e:Event):void
        {
            print("Adman: Ad Banner Started");
        }

        private function onAdBannerStopped(e:Event):void
        {
            print("Adman: Ad Banner Stopped");
        }

        private function onAdBannerCompleted(e:Event):void
        {
            print("Adman: Ad Banner Completed");
        }

        private function onResize(e:Event=null):void
        {
            if (vkContainer)
            {
                vkContainer.setSize(stage.stageWidth, stage.stageHeight);
            }

        }

        public function print(msg:String):void
        {
            msg = "\n" + msg;
            LogTextField.appendText(msg);
        }

    }
}