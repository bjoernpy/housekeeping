# Housekeeping App

## Development

### Supported Android Versions

- Android 8+

### Adding a splash screen

Splashscreen from https://www.drawkit.io/illustrations/breakfast-colour

```bash
$ flutter pub pub run flutter_native_splash:create
```

After creating the images one needs to add the following lines to the `launch_background.xml`-file.

```xml
    <item>
        <bitmap android:gravity="center" android:src="@drawable/splash" />
    </item>
```
