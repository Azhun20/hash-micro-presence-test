import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String toTimeAgo() {
    final date = this;
    if (date == null) return '-';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks minggu lalu';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan lalu';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years tahun lalu';
    }
  }

  String toTimeAgoInDays() {
    final date = this;
    if (date == null) return '-';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (now.year == date.year) {
      final months = DateFormat('d MMM', 'id_ID').format(date.toLocal());
      return months;
    } else {
      final years = DateFormat('d MMM yyyy', 'id_ID').format(date.toLocal());
      return years;
    }
  }

  String toTimeWithDays() {
    final date = this;
    if (date == null) return '-';

    final now = DateTime.now();
    final localDate = date.toLocal();

    // Normalize dates to compare only date part (ignore time)
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(localDate.year, localDate.month, localDate.day);

    // Format time as HH.mm
    final time = DateFormat('HH.mm', 'id_ID').format(localDate);

    if (dateOnly == today) {
      // Hari ini
      return 'Hari ini pukul $time';
    } else if (dateOnly == yesterday) {
      // Kemarin
      return 'Kemarin pukul $time';
    } else if (now.year == localDate.year) {
      // Tahun sama, tampilkan dd MMM pukul HH.mm
      final dateStr = DateFormat('d MMM', 'id_ID').format(localDate);
      return '$dateStr pukul $time';
    } else {
      // Beda tahun, tampilkan dd MMM yyyy pukul HH.mm
      final dateStr = DateFormat('d MMM yyyy', 'id_ID').format(localDate);
      return '$dateStr pukul $time';
    }
  }
}

extension DateTimeStringExt on String? {
  /// Parse ISO 8601 datetime string (e.g., "2025-10-30T08:43:56.000000Z") to relative time
  /// Returns format like "2 jam yang lalu", "3 hari lalu", etc.
  String toTimeAgo() {
    final dateString = this;
    if (dateString == null || dateString.isEmpty) return '-';

    try {
      // Parse ISO 8601 format datetime string
      final dateTime = DateTime.parse(dateString);
      // Convert to local timezone
      final localDateTime = dateTime.toLocal();
      // Use existing DateTime extension
      return localDateTime.toTimeAgo();
    } catch (e) {
      // If parsing fails, return original string
      return dateString;
    }
  }

  String toTimeAgoInDays() {
    final dateString = this;
    if (dateString == null || dateString.isEmpty) return '-';

    try {
      // Parse ISO 8601 format datetime string
      final dateTime = DateTime.parse(dateString);
      // Convert to local timezone
      final localDateTime = dateTime.toLocal();
      // Use existing DateTime extension
      return localDateTime.toTimeAgoInDays();
    } catch (e) {
      // If parsing fails, return original string
      return dateString;
    }
  }

  String toTimeWithDays() {
    final dateString = this;
    if (dateString == null || dateString.isEmpty) return '-';

    try {
      // Parse ISO 8601 format datetime string
      final dateTime = DateTime.parse(dateString);
      // Convert to local timezone
      final localDateTime = dateTime.toLocal();
      // Use existing DateTime extension
      return localDateTime.toTimeWithDays();
    } catch (e) {
      // If parsing fails, return original string
      return dateString;
    }
  }
}

extension DateTimeStringFormat on String? {
  String? formatTime() {
    final date = DateTime.tryParse(this ?? "");
    if (date != null) {
      return DateFormat("dd MMMM yyyy").format(date);
    }
    return null;
  }
}
