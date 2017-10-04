package com.baidumeetsreactnative;

import android.content.Context;
import android.os.Bundle;
import com.baidu.mapapi.SDKInitializer;
import com.facebook.react.ReactActivity;

public class MainActivity extends ReactActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SDKInitializer.initialize(getApplicationContext());
    }

    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "BaiduMeetsReactNative";
    }


}
