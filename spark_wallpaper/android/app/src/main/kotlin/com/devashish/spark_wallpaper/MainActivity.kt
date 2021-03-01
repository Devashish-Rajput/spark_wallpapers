package com.devashish.spark_wallpaper

import android.annotation.SuppressLint
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.IOException
import android.app.WallpaperManager
import android.graphics.BitmapFactory
import android.os.Build 
import android.annotation.TargetApi
import android.content.Context
import androidx.annotation.RequiresApi

private const val CHANNEL = "com.devashish.spark_wallpaper/wallpaper"
class MainActivity: FlutterActivity() {

    @RequiresApi(Build.VERSION_CODES.N)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setWallpaper") {
                val arguments = call.arguments as ArrayList<*>
                val setWallpaper = setWallpaper(arguments[0] as String, applicationContext, arguments[1] as Int)

                if (setWallpaper == 0) {
                    result.success(setWallpaper)
                } else {
                    result.error("UNAVAILABLE", "", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    @SuppressLint("MissingPermission")
    @RequiresApi(Build.VERSION_CODES.N)
    @TargetApi(Build.VERSION_CODES.ECLAIR)
    private fun setWallpaper(path: String, applicationContext: Context, wallpaperType: Int): Int {
        var setWallpaper = 1
        val bitmap = BitmapFactory.decodeFile(path)
        val wm: WallpaperManager? = WallpaperManager.getInstance(applicationContext)
        setWallpaper = try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                wm?.setBitmap(bitmap, null, true, wallpaperType)
            }
            0
        } catch (e: IOException) {
            1
        }

        return setWallpaper
    }
}
