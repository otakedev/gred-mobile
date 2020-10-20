package com.example.gred_mobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.media.AudioManager
import android.app.NotificationManager;
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity : FlutterActivity() {
  private var volumeLevel = 0
  private val CHANNEL = "gred_mobile/audio_manager"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == "setStreamMusicMute") {
        if (VERSION.SDK_INT > VERSION_CODES.M) {
          // NOT WORKING
          // this.requestDoNotDisturbPermissionOrSetDoNotDisturbApi23AndUp()
        } else {
          mute()
        }
        result.success(true)
      } else if (call.method == "setStreamMusicUnmute") {
        if (VERSION.SDK_INT <= VERSION_CODES.M) {
          unmute()
        }
        result.success(true)
      } else {
        result.notImplemented()
      }
    }
  }

  fun requestDoNotDisturbPermissionOrSetDoNotDisturbApi23AndUp() {
    val nm = getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    if (nm.isNotificationPolicyAccessGranted()) {
      mute()
    } else{
      val intent = Intent(android.provider.Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
      // startActivityForResult(intent, 1)
      startActivity(intent)
      if (nm.isNotificationPolicyAccessGranted()) {
        mute()
      }
    }
  }

  fun mute(){
    val am = getApplicationContext().getSystemService(Context.AUDIO_SERVICE) as AudioManager
    volumeLevel = am.getStreamVolume(AudioManager.STREAM_NOTIFICATION)
    am.setStreamVolume(AudioManager.STREAM_NOTIFICATION, 0, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE)
  }

  fun unmute(){
    val am = getSystemService(Context.AUDIO_SERVICE) as AudioManager
    am.setStreamVolume(AudioManager.STREAM_NOTIFICATION, volumeLevel, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
    if (requestCode == 1) {
      requestDoNotDisturbPermissionOrSetDoNotDisturbApi23AndUp()
    }
  }
}
