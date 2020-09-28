// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CVRate extends DataClass implements Insertable<CVRate> {
  final String currency;
  final double value;
  CVRate({@required this.currency, @required this.value});
  factory CVRate.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return CVRate(
      currency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}currency']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    return map;
  }

  CVRatesCompanion toCompanion(bool nullToAbsent) {
    return CVRatesCompanion(
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory CVRate.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CVRate(
      currency: serializer.fromJson<String>(json['currency']),
      value: serializer.fromJson<double>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'currency': serializer.toJson<String>(currency),
      'value': serializer.toJson<double>(value),
    };
  }

  CVRate copyWith({String currency, double value}) => CVRate(
        currency: currency ?? this.currency,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('CVRate(')
          ..write('currency: $currency, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(currency.hashCode, value.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CVRate &&
          other.currency == this.currency &&
          other.value == this.value);
}

class CVRatesCompanion extends UpdateCompanion<CVRate> {
  final Value<String> currency;
  final Value<double> value;
  const CVRatesCompanion({
    this.currency = const Value.absent(),
    this.value = const Value.absent(),
  });
  CVRatesCompanion.insert({
    @required String currency,
    @required double value,
  })  : currency = Value(currency),
        value = Value(value);
  static Insertable<CVRate> custom({
    Expression<String> currency,
    Expression<double> value,
  }) {
    return RawValuesInsertable({
      if (currency != null) 'currency': currency,
      if (value != null) 'value': value,
    });
  }

  CVRatesCompanion copyWith({Value<String> currency, Value<double> value}) {
    return CVRatesCompanion(
      currency: currency ?? this.currency,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CVRatesCompanion(')
          ..write('currency: $currency, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $CVRatesTable extends CVRates with TableInfo<$CVRatesTable, CVRate> {
  final GeneratedDatabase _db;
  final String _alias;
  $CVRatesTable(this._db, [this._alias]);
  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  GeneratedTextColumn _currency;
  @override
  GeneratedTextColumn get currency => _currency ??= _constructCurrency();
  GeneratedTextColumn _constructCurrency() {
    return GeneratedTextColumn('currency', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn(
      'value',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [currency, value];
  @override
  $CVRatesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'c_v_rates';
  @override
  final String actualTableName = 'c_v_rates';
  @override
  VerificationContext validateIntegrity(Insertable<CVRate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency'], _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  CVRate map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CVRate.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CVRatesTable createAlias(String alias) {
    return $CVRatesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CVRatesTable _cVRates;
  $CVRatesTable get cVRates => _cVRates ??= $CVRatesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cVRates];
}
