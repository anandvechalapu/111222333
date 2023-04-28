using System.Threading.Tasks;
using 111222333.DTO;

namespace 111222333.Service
{
    public interface IBatchProcessRepository
    {
        Task<BatchProcess> GetBatchProcessByIdAsync(int id);
        Task<int> CreateBatchProcessAsync(BatchProcess batchProcess);
        Task<bool> UpdateBatchProcessAsync(BatchProcess batchProcess);
        Task<bool> DeleteBatchProcessAsync(int id);
    }
}