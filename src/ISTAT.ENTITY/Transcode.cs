using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{

    public class TranscodeTime
    {

        public struct TimePeriodSplitted {
            public int year;
            public TypePeriod type;
            public int period;
        }

        public enum TypePeriod
        {
            M = 0,
            A = 1,
            S = 2,
            Q = 3
        }

        public string stopChar = "-";
        public TypePeriod periodChar = TypePeriod.M;

        public string TransCodific(string code)
        {
            try
            {
                int count = code.IndexOf(this.stopChar);
                string part_year = code.Substring(0, count);
                string part_month = code.Substring(count + (this.stopChar.Length), code.Length - (count + (this.stopChar.Length)));
                int month;
                if (int.TryParse(part_month, out month))
                {
                    return part_year + periodChar + month;
                }
                else
                {
                    return part_year + periodChar;
                }
            }
            catch// (Exception ex)
            {
                return code;
            }
        }

        private static TimePeriodSplitted GetTimePeriodSplitted(string time_period) {
            
            TimePeriodSplitted _t=new TimePeriodSplitted();

            if (time_period == null || time_period == string.Empty)
                return _t;

            if (time_period.Length == 4)
            {
                // a is year
                _t.year = int.Parse(time_period);
                _t.period = 0;
                _t.type = TypePeriod.A;
            }
            else
            {
                _t.year = int.Parse(time_period.Substring(0, 4));
                _t.type = (TypePeriod)Enum.Parse(typeof(TypePeriod), time_period.ToUpper().Substring(4, 1));
                _t.period = int.Parse(time_period.Substring(5, time_period.Length - 5));
            }

            return _t;

        }

        public static string CompareMin(string a, string b) {

            /* time format
             * * 1900M1
             * * 1900M2
             * * 1900M3
             * * ....
             * * 1900M10
             * * 1900M11
             * * 1900M12
             * * 1900Q1
             * * 1900Q2
             * * 1900Q3
             * * 1900Q4
             * 1900S1
             * 1900
             * */

            if (a == null || a == string.Empty) return b;
            if (b == null || b == string.Empty) return a;


            TimePeriodSplitted _t_a = TranscodeTime.GetTimePeriodSplitted(a);
            TimePeriodSplitted _t_b = TranscodeTime.GetTimePeriodSplitted(b);

            if (_t_a.year < _t_b.year) return a;
            if (_t_b.year < _t_a.year) return b;

            if (_t_a.year == _t_b.year)
            {
                if ((_t_a.type == TypePeriod.M && _t_b.type == TypePeriod.M) ||
                    (_t_a.type == TypePeriod.Q && _t_b.type == TypePeriod.Q))
                {
                    if (_t_a.period <= _t_b.period) return a;

                    if (_t_b.period < _t_a.period) return b;
                }
                else if (_t_a.type == TypePeriod.Q && _t_b.type == TypePeriod.M)
                {
                    if (_t_a.period * 3 <= _t_b.period) return a;
                    else return b;
                }
                else if (_t_a.type == TypePeriod.M && _t_b.type == TypePeriod.Q)
                {
                    if (_t_b.period * 3 <= _t_a.period) return b;
                    else return a;
                }
            }
            
            return a;
        }
        public static string CompareMax(string a, string b)
        {

            /* time format
             * * 1900M1
             * * 1900M2
             * * 1900M3
             * * ....
             * * 1900M10
             * * 1900M11
             * * 1900M12
             * * 1900Q1
             * * 1900Q2
             * * 1900Q3
             * * 1900Q4
             * 1900S1
             * 1900
             * */

            if (a == null || a == string.Empty) return b;
            if (b == null || b == string.Empty) return a;


            TimePeriodSplitted _t_a = TranscodeTime.GetTimePeriodSplitted(a);
            TimePeriodSplitted _t_b = TranscodeTime.GetTimePeriodSplitted(b);

            if (_t_a.year > _t_b.year) return a;
            if (_t_b.year > _t_a.year) return b;

            if (_t_a.year == _t_b.year)
            {
                if ((_t_a.type == TypePeriod.M && _t_b.type == TypePeriod.M) ||
                    (_t_a.type == TypePeriod.Q && _t_b.type == TypePeriod.Q))
                {
                    if (_t_a.period >= _t_b.period) return a;

                    if (_t_b.period > _t_a.period) return b;
                }
                else if (_t_a.type == TypePeriod.Q && _t_b.type == TypePeriod.M)
                {
                    if (_t_a.period * 3 >= _t_b.period) return a;
                    else return b;
                }
                else if (_t_a.type == TypePeriod.M && _t_b.type == TypePeriod.Q)
                {
                    if (_t_b.period * 3 >= _t_a.period) return b;
                    else return a;
                }
            }

            return a;
        }
    }
}
