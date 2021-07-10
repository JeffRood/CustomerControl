using System;
using CC.BusinessLayer.Interfaces.IResultOperation;

namespace CC.BusinessLayer.Helper
{
    public class ResultOperation<T> : IResultOperation<T>
    {
        ResultOperation(string message, bool success, T entity)
        {
            Message = message;
            Success = success;
            Entity = entity;
        }

        public new string Message { get; }

        public new bool Success { get; }

        public new T Entity { get; }

        public static ResultOperation<T> Ok(string Mensaje)
            => new ResultOperation<T>(Mensaje, true, default(T));

        public static ResultOperation<T> Ok(T entity)
            => new ResultOperation<T>("", true, entity);

        public static ResultOperation<T> Fail(string message)
            => new ResultOperation<T>(message, false, default(T));
    }
}
