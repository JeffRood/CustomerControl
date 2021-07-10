using System;
namespace CC.BusinessLayer.Interfaces.IResultOperation
{
    public class IResultOperation<T>
    {
        public string Message { get; }
        public bool Success { get; }
        public T Entity { get; }

    }
}
